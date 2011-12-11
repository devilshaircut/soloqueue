class AddDisplayNameToWikiaCache < ActiveRecord::Migration
  def change
    add_column :wikia_caches, :display_name, :string
  end
end
