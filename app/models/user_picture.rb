class UserPicture < ActiveRecord::Base
  belongs_to :user
  
  validates :user, :photo_token, presence: true
end
