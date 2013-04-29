class RenameUrlToSlugIntoTheCategories < ActiveRecord::Migration
  def change
    rename_column :categories, :url, :slug
  end
end
