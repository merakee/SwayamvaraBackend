class CreateBlacklistReasons < ActiveRecord::Migration
  def change
    create_table :blacklist_reasons do |t|
    t.string :reason, null: false, unique: true
    end
  end
end
