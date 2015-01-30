class FlaggedUser < ActiveRecord::Base
  belongs_to :user 
  belongs_to :flagging_reason
  
  validates :user, :flagging_reason, :userid_flagged, presence: true
  validates :user_id, uniqueness: { scope: [:flagging_reason, :userid_flagged],
    message: "User already flagged this user for the same reason." }
  validates :flagging_reason, inclusion: 0..4
  
end
