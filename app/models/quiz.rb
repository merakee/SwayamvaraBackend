class Quiz < ActiveRecord::Base
  belongs_to :quiz_category
  has_many :user_quiz_selection, dependent: :destroy
  
  validates :quiz_category, :question, :choice1, :choice2, :choice3, :choice4, presence: true
end
