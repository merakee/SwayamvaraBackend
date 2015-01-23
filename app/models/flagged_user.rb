class FlaggedUser < ActiveRecord::Base
  belongs_to :user 
  belongs_to :flagging_reason
  validates :userid_flagged, presence: true
end
