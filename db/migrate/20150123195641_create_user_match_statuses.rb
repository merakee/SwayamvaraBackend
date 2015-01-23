class CreateUserMatchStatuses < ActiveRecord::Migration
  def change
    create_table :user_match_statuses do |t|
      t.string :status, null: false, unique: true
      t.timestamps
    end
  end
end
