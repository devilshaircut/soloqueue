class CreateWikiaCaches < ActiveRecord::Migration
  def change
    create_table :wikia_caches do |t|
      t.text :wikiacache

      t.timestamps
    end
  end
end
