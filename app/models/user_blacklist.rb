class UserBlacklist < ActiveRecord::Base
  belongs_to :user
  
  validates :user, :userid_blacklisted, :blacklist_reason, presence: true
  validates :user_id, uniqueness: { scope: [:userid_blacklisted,:blacklist_reason_id],
    message: "User already blacklisted this user for the same reason." }
  validates :blacklist_reason, inclusion: 0..4
end
