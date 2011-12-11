class CreateSearches < ActiveRecord::Migration
  def change
    create_table :searches do |t|
      t.string :value
      t.string :ip

      t.timestamps
    end
  end
end
