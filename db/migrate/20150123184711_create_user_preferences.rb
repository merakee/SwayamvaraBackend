class CreateUserPreferences < ActiveRecord::Migration
  def change
    create_table :user_preferences do |t|
      t.belongs_to :user , null: false , limit: 8 
      t.integer :distance, null: false, default: 0 
      t.integer :age, null: false, default: 1 
      t.integer :ralationship, null: false, default: 1 
      #t.string :movie, :array => true, default: '{}'
      #t.string :music, :array => true, default: '{}'
      #t.string :activity, :array => true, default: '{}'
      #t.string :food, :array => true, default: '{}'
      #t.string :language, :array => true, default: '{}'

      t.timestamps
    end
    
    add_index :user_preferences, :user_id
    
  end
end
