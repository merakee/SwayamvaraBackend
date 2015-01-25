class FlaggedUser < ActiveRecord::Base
  belongs_to :user 
  belongs_to :flagging_reason
  
  validates :user, :flagging_reason, :userid_flagged, presence: true
end
