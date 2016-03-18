class ChangeWikiSlugNulltoFalse < ActiveRecord::Migration
  def change
    change_column :wikis, :slug, :string, :null => false
  end
end
