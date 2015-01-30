class UserPreference < ActiveRecord::Base
  belongs_to :user

  validates :user, presence: true
  validates :distance, numericality: {greater_than_or_equal_to:-10000, less_than_or_equal_to: 10000}
  validates :age, inclusion: 1..4
  validates :relationship, inclusion: 1..3
end
