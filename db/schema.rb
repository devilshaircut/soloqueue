# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20120126021741) do


  create_table "champions", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "champion_full_name"
    t.integer  "riot_id"
    t.float    "damage"
    t.float    "damage_per_level"
    t.float    "health"
    t.float    "health_per_level"
    t.float    "resource"
    t.float    "resource_per_level"
    t.float    "move_speed"
    t.float    "armor"
    t.float    "armor_per_level"
    t.float    "magic_resist"
    t.float    "magic_resist_per_level"
    t.float    "health_regen"
    t.float    "health_regen_per_level"
    t.float    "resource_regen"
    t.float    "resource_regen_per_level"
    t.string   "resource_name"
    t.string   "attributes_table"
  end

  create_table "counterpick_caches", :force => true do |t|
    t.text     "latestcounterpick"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "reasons", :force => true do |t|
    t.string   "title"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "searches", :force => true do |t|
    t.string   "value"
    t.string   "ip"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "skills", :force => true do |t|
    t.integer  "champion_id"
    t.string   "image_url"
    t.string   "name"
    t.text     "description"
    t.text     "effect"
    t.string   "cost"
    t.integer  "range"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "email",                                 :default => "", :null => false
    t.string   "encrypted_password",     :limit => 128, :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                         :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

  create_table "votes", :force => true do |t|
    t.integer  "user_id"
    t.integer  "champion_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "reason_id"
    t.integer  "counterpick_id"
  end

  create_table "wikia_caches", :force => true do |t|
    t.integer  "wikiaid"
    t.string   "wikianame"
    t.text     "latestwikia"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "display_name"
  end

end
