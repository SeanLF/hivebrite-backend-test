# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_06_22_003040) do

  create_table "event_registration_attributes", force: :cascade do |t|
    t.integer "event_id", null: false
    t.string "name", null: false
    t.string "data_type", null: false
    t.boolean "required", default: false, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index "\"event_id\", \"lower(name)\"", name: "index_event_registration_attributes_on_event_id_&_lower(name)", unique: true
    t.index ["event_id"], name: "index_event_registration_attributes_on_event_id"
  end

  create_table "event_registrations", force: :cascade do |t|
    t.integer "event_id", null: false
    t.integer "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["event_id"], name: "index_event_registrations_on_event_id"
    t.index ["user_id", "event_id"], name: "index_event_registrations_on_user_id_and_event_id", unique: true
    t.index ["user_id"], name: "index_event_registrations_on_user_id"
  end

  create_table "events", force: :cascade do |t|
    t.string "name", null: false
    t.json "custom_attributes"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "user_attribute_values", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "user_attribute_id", null: false
    t.text "value", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_attribute_id"], name: "index_user_attribute_values_on_user_attribute_id"
    t.index ["user_id", "user_attribute_id"], name: "index_user_attribute_values_on_user_id_and_user_attribute_id", unique: true
    t.index ["user_id"], name: "index_user_attribute_values_on_user_id"
  end

  create_table "user_attributes", force: :cascade do |t|
    t.string "name", null: false
    t.string "data_type", null: false
    t.boolean "required_on_signup", default: false, null: false
    t.boolean "required_on_profile", default: false, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index "lower(name)", name: "index_user_attributes_on_lower_name", unique: true
  end

  create_table "users", force: :cascade do |t|
    t.text "username", null: false
    t.text "password", null: false
    t.boolean "admin", default: false, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index "lower(username)", name: "index_users_on_lower_username", unique: true
  end

  add_foreign_key "event_registration_attributes", "events"
  add_foreign_key "event_registrations", "events"
  add_foreign_key "event_registrations", "users"
  add_foreign_key "user_attribute_values", "user_attributes"
  add_foreign_key "user_attribute_values", "users"
end
