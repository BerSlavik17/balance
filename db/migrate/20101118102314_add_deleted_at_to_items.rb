class AddDeletedAtToItems < ActiveRecord::Migration
  def self.up
    add_column :items, :deleted_at, :time
    Item.unscoped.where(:deleted => true).update_all(:deleted_at => Time.now)
    remove_column :items, :deleted
  end

  def self.down
    add_column :items, :deleted, :boolean, :default => false
    Item.only_deleted.update_all(:deleted => true)
    remove_column :items, :deleted_at
  end
end
