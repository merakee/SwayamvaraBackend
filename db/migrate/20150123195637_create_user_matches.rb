class CreateUserMatches < ActiveRecord::Migration
  def change
    create_table :user_matches do |t|
      t.belongs_to :user , null: false ,:limit => 8
      t.integer :userid_matched, null: false , :limit => 8
      t.belongs_to :user_match_status 
      t.timestamp :expiry_time 
      t.timestamps
    end
  end
end
