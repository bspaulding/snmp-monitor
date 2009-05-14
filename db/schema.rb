# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20090504145957) do

  create_table "agents", :force => true do |t|
    t.string   "ip_address"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
    t.string   "community"
    t.boolean  "favorite"
  end

  create_table "agents_mibs", :id => false, :force => true do |t|
    t.integer "agent_id"
    t.integer "mib_id"
  end

  create_table "data_records", :force => true do |t|
    t.integer  "agent_id"
    t.integer  "mib_object_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "mib_objects", :force => true do |t|
    t.string   "name"
    t.string   "oid"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "mib_id"
  end

  create_table "mibs", :force => true do |t|
    t.string   "name"
    t.string   "oid"
    t.string   "module_location"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "traps", :force => true do |t|
    t.string   "uptime"
    t.string   "oid"
    t.integer  "agent_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "email"
    t.string   "password_hash"
    t.string   "password_salt"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
