class UserRating < ActiveRecord::Base
  belongs_to :user
  
  validates :user, :userid_ratings_from, presence: true 
end
