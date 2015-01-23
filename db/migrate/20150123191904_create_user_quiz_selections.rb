class CreateUserQuizSelections < ActiveRecord::Migration
  def change
    create_table :user_quiz_selections do |t|
      t.belongs_to :user , :limit => 8
      t.belongs_to :quiz
      t.integer :userid_selected, null: false , :limit => 8
      t.integer :selector_choice, null: false
      t.integer :responder_choice, null: false
      t.timestamps
    end
  end
end
