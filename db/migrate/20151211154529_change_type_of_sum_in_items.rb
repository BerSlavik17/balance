class ChangeTypeOfSumInItems < ActiveRecord::Migration
  def change
    change_column :items, :sum, :decimal, precision: 10, scale: 2, null: false
  end
end
