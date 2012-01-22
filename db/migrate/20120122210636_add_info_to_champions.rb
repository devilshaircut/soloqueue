class AddInfoToChampions < ActiveRecord::Migration
  def change
    add_column :champions, :champion_full_name, :string
    add_column :champions, :riot_id, :integer
    add_column :champions, :damage, :float
    add_column :champions, :damage_per_level, :float
    add_column :champions, :health, :float
    add_column :champions, :health_per_level, :float
    add_column :champions, :resource, :float
    add_column :champions, :resource_per_level, :float
    add_column :champions, :move_speed, :float
    add_column :champions, :armor, :float
    add_column :champions, :armor_per_level, :float
    add_column :champions, :magic_resist, :float
    add_column :champions, :magic_resist_per_level, :float
    add_column :champions, :health_regen, :float
    add_column :champions, :health_regen_per_level, :float
    add_column :champions, :resource_regen, :float
    add_column :champions, :resource_regen_per_level, :float
    add_column :champions, :resource_name, :string
  end
end
