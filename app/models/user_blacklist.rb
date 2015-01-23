class UserBlacklist < ActiveRecord::Base
  belongs_to :user
  belongs_to :blacklist_reason
  validates :userid_blacklisted, presence: true
  
end
