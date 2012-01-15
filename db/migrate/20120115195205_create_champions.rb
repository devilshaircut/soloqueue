class CreateChampions < ActiveRecord::Migration
  def change
    create_table :champions do |t|
      t.string :name

      t.timestamps
    end
  end
end
