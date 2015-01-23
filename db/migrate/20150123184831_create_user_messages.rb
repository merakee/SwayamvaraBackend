class CreateUserMessages < ActiveRecord::Migration
  def change
    create_table :user_messages do |t|
      t.belongs_to :user , null: false , :limit => 8
      t.integer :userid_sent_to, null: false , :limit => 8
      t.string :message, null: false
      t.timestamps
    end
  end
end
