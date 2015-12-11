class ChangeTypeOfSumColumnIntoCashes < ActiveRecord::Migration
  def change
    change_column :cashes, :sum, :decimal, precision: 10, scale: 2, null: false
  end
end
