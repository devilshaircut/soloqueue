class CreateSkills < ActiveRecord::Migration
  def change
    create_table :skills do |t|
      t.integer :champion_id
      t.string :image_url
      t.string :name
      t.text :description
      t.text :effect
      t.string :cost
      t.integer :range

      t.timestamps
    end
  end
end
