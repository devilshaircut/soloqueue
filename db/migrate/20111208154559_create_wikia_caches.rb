class CreateWikiaCaches < ActiveRecord::Migration
  def change
    create_table :wikia_caches do |t|
      t.string :wikianame
      t.text :latestwikia

      t.timestamps
    end
  end
end
