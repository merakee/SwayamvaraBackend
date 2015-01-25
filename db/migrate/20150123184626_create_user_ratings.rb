class CreateUserRatings < ActiveRecord::Migration
  def change
    create_table :user_ratings do |t|
      t.belongs_to :user , null: false ,limit: 8 
      t.integer :userid_ratings_from, null: false , limit: 8 
      t.boolean :funny
      t.boolean :smart 
      t.boolean :friendly
      t.boolean :interesting    
      t.timestamps
    end
    
    add_index :user_ratings, [:user_id, :userid_ratings_from]
  end
end
