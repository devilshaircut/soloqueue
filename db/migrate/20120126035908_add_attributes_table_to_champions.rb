class AddAttributesTableToChampions < ActiveRecord::Migration
  def change
    add_column :champions, :attributes_table, :string
  end
end
