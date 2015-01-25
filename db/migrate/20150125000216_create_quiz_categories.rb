class CreateQuizCategories < ActiveRecord::Migration
  def change
    create_table :quiz_categories do |t|
      t.string :category, null: false, unique: true
    end
  end
end
