class CreateFlaggingReasons < ActiveRecord::Migration
  def change
    create_table :flagging_reasons do |t|
      t.string :reason, null: false, unique: true
    end
  end
end
