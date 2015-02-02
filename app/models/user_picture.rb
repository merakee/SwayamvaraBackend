class UserPicture < ActiveRecord::Base
  belongs_to :user

  validates :user, :photo_token, :is_private, :display_order, presence: true
  validates :display_order, uniqueness: { scope: [:user_id],
    message: "There is already a picture with this display order." }

  # carried wave - uploader
  mount_uploader :photo_token, UserPhotoUploader

end
