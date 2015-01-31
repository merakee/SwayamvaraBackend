class Quiz < ActiveRecord::Base
  has_many :user_quiz_selection, dependent: :destroy
  
  validates :quiz_category, :question, :choice1, :choice2, :choice3, :choice4, presence: true
  validates :quiz_category, inclusion: 0..10
end
