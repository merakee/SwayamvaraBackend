class UserMatch < ActiveRecord::Base
  belongs_to :user
  
  validates :user, :userid_matched, :user_match_status, :expiry_time,  presence: true
  validates :user_match_status, inclusion: 0..4
end
