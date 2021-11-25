# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2021_11_25_121032) do

  create_table "owners", force: :cascade do |t|
    t.string "name"
    t.integer "phone"
    t.string "email"
    t.string "password_digest"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "passengers", force: :cascade do |t|
    t.string "email", null: false
    t.string "phone", null: false
    t.string "password_digest"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "rents", force: :cascade do |t|
    t.string "start_location"
    t.string "destination"
    t.integer "seats"
    t.integer "ride_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["ride_id"], name: "index_rents_on_ride_id"
  end

  create_table "rides", force: :cascade do |t|
    t.string "vehicle_no"
    t.integer "seats"
    t.string "start_point"
    t.string "stop1"
    t.string "stop2"
    t.string "stop3"
    t.string "stop4"
    t.string "final_stop"
    t.string "cost"
    t.string "integer"
    t.integer "discount"
    t.integer "owner_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["owner_id"], name: "index_rides_on_owner_id"
  end

  create_table "vehicles", force: :cascade do |t|
    t.string "vehicle_no"
    t.integer "seats"
    t.string "start_point"
    t.string "stop1"
    t.string "stop2"
    t.string "stop3"
    t.string "stop4"
    t.string "final_stop"
    t.string "cost"
    t.string "integer"
    t.integer "discount"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  add_foreign_key "rents", "rides"
  add_foreign_key "rides", "owners"
end
