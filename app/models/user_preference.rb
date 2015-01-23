class UserPreference < ActiveRecord::Base
  belongs_to :user
  validates :distance, presence: true, numericality: {greater_than_or_equal_to:-10000, less_than_or_equal_to: 10000}
end
