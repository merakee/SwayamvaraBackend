class UserMessage < ActiveRecord::Base
  belongs_to :user
  
  validates  :user, :userid_sent_to, :message, :created_at, presence: true 
end
