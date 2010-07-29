class DropSessionsTable < ActiveRecord::Migration
  def self.up
    drop_table :sessions
  end

  def self.down
    create_table "sessions", :force => true do |t|
      t.string   "hashid",     :limit => 32
      t.datetime "created_at"
      t.text     "ivars"
    end
  end
end
