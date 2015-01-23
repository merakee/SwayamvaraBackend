class UserProfile < ActiveRecord::Base
  belongs_to :user
  validates :user_name, presence: true, length: {in: 4..16}
  validates :birth_year, presence: true, inclusion: 1900..2000
  validates :sex , presence: true, inclusion: {:in => %w[F M]}
  validates :sex_preferred , presence: true, inclusion: {:in => %w[F M]}
  validates :height, presence: true, numericality: {greater_than_or_equal_to:1.0, less_than_or_equal_to: 10.0 }
  validates :weight, presence: true, numericality: {greater_than_or_equal_to:10.0, less_than_or_equal_to: 500.0 }
end
