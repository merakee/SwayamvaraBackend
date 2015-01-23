class UserQuizSelection < ActiveRecord::Base
  belongs_to :user
  belongs_to :quiz
  validates :user , :userid_selected, :quiz, presence: true
  validates :selector_choice, presence: true, inclusion: 1..4
  validates :responder_choice, presence: true, inclusion: 1..4
end
