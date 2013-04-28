class RenameSummaToFormulaIntoTheItems < ActiveRecord::Migration
  def change
    rename_column :items, :summa, :formula
  end
end
