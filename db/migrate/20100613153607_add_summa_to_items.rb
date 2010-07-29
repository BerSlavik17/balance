class AddSummaToItems < ActiveRecord::Migration
  def self.up
    add_column :items, :summa, :text
  end

  def self.down
    remove_column :items, :summa
  end
end
