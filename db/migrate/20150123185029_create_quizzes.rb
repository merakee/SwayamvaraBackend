class CreateQuizzes < ActiveRecord::Migration
  def change
    create_table :quizzes do |t|
      t.integer :category, default: 1, null: false
      t.string :question, default: "", null: false
      t.string :choice1, default: "", null: false
      t.string :choice2, default: "", null: false
      t.string :choice3, default: "", null: false
      t.string :choice4, default: "", null: false
    end
  end
end
