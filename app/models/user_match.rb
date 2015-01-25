class UserMatch < ActiveRecord::Base
  belongs_to :user
  belongs_to :user_match_status
  
  validates :user, :userid_matched, :user_match_status, :expiry_time,  presence: true
end
