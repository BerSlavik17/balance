class AddFormulaToCashes < ActiveRecord::Migration
  def change
    add_column :cashes, :formula, :string
  end
end
