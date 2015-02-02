class CreateUserMatches < ActiveRecord::Migration
  def change
    create_table :user_matches do |t|
      t.belongs_to :user , null: false ,limit: 8 
      t.integer :userid_matched, null: false , limit: 8 
      t.integer :user_match_status, null: false, default: 0
      t.timestamp :expiry_time 
      t.timestamps
    end
    
    add_index :user_matches, [:user_id, :userid_matched]
  end
end
