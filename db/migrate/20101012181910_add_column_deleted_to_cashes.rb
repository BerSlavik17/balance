class AddColumnDeletedToCashes < ActiveRecord::Migration
  def self.up
    add_column :cashes, :deleted, :boolean, :default => false
  end

  def self.down
    remove_column :cashes, :deleted
  end
end
