class AddSlugToWiki < ActiveRecord::Migration
  def change
    add_column :wikis, :slug, :string
    add_index :wikis, :slug, :unique => true
  end
end
