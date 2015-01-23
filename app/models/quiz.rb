class Quiz < ActiveRecord::Base
  has_many :user_quiz_selection, dependent: :destroy
end
