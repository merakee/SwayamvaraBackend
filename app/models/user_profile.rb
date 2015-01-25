class UserProfile < ActiveRecord::Base
  belongs_to :user

  validates :user, presence: true
  validates :user_name, presence: true, length: {in: 4..16} # , format: /\A[\sa-z0-9]+\Z/i
  validates :birth_year, presence: true, inclusion: 1900..2000
  validates :sex , presence: true, inclusion: {:in => %w[F M]}
  validates :sex_preferred , presence: true, inclusion: {:in => %w[F M]}
  validates :height, numericality: {greater_than_or_equal_to:1.0, less_than_or_equal_to: 10.0 }#,presence: true,
  validates :weight, numericality: {greater_than_or_equal_to:10.0, less_than_or_equal_to: 500.0 }#,presence: true,

  before_save :asign_opposite_sex_preferred!

  private
  def asign_opposite_sex_preferred!
    self.sex_preferred = (self.sex.eql? "M")?"F":"M"
  end
end

# Note
# alpha numeric validation of a string
# validates :user_name, format: /\A[\sa-z0-9]+\Z/i
