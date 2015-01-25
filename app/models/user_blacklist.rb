class UserBlacklist < ActiveRecord::Base
  belongs_to :user
  belongs_to :blacklist_reason
  
  validates :user, :userid_blacklisted, :blacklist_reason, presence: true
end
