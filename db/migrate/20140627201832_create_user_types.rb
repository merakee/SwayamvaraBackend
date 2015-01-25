class CreateUserTypes < ActiveRecord::Migration
  def change
    create_table :user_types do |t|
      t.string :user_type, null: false, unique: true
    end
  end
end
