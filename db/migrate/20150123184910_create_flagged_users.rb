class CreateFlaggedUsers < ActiveRecord::Migration
  def change
    create_table :flagged_users do |t|
      t.belongs_to :user , null: false , :limit => 8
      t.integer :userid_flagged, null: false , :limit => 8
      t.belongs_to :flagging_reason, null: false
      t.timestamps
    end
  end
end
