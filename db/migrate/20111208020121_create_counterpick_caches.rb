class CreateCounterpickCaches < ActiveRecord::Migration
  def change
    create_table :counterpick_caches do |t|
      t.text :latestcounterpick

      t.timestamps
    end
  end
end
