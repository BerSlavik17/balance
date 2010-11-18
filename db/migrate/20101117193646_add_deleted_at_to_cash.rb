class AddDeletedAtToCash < ActiveRecord::Migration
  def self.up
    add_column :cashes, :deleted_at, :time
    Cash.unscoped.where(:deleted => true).update_all(:deleted_at => Time.now)
    remove_column :cashes, :deleted
  end

  def self.down
    add_column :cashes, :deleted, :boolean, :default => false
    Cash.only_deleted.update_all(:deleted => true)
    remove_column :cashes, :deleted_at
  end
end
