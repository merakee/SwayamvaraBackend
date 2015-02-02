class CreateUserPictures < ActiveRecord::Migration
  def change
    create_table :user_pictures do |t|
      t.belongs_to :user , null: false, limit: 8 
      t.integer :display_order, default: 0, null: false
      t.boolean :is_private, default: false, null: false
      t.string :photo_token, default: "", null: false
      t.timestamps
    end
    
    add_index :user_pictures, :user_id
  end
end
