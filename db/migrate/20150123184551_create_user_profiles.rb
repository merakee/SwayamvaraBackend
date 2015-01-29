class CreateUserProfiles < ActiveRecord::Migration
  def change
    create_table :user_profiles do |t|
      t.belongs_to :user , null: false , limit: 8 
      t.string  :user_name, null: false 
      t.integer :birth_year, null: false 
      t.string  :sex , null: false 
      t.string  :sex_preferred , null: false 
      t.decimal :height, null: false , :precision => 3, :scale => 1 # NN.N
      t.decimal  :weight, null: false , :precision => 4, :scale => 1 # NNN.N
      t.timestamps
    end
  end
end
