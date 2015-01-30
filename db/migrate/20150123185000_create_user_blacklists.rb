class CreateUserBlacklists < ActiveRecord::Migration
  def change
    create_table :user_blacklists do |t|
      t.belongs_to :user , null: false ,limit: 8 
      t.integer :userid_blacklisted, null: false , limit: 8 
      t.integer :blacklist_reason, null: false, default: 0
      t.timestamps
    end
    
    add_index :user_blacklists, [:user_id, :userid_blacklisted]
  end
end
