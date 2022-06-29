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

ActiveRecord::Schema.define(version: 2022_06_29_140644) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "apartments", force: :cascade do |t|
    t.string "project"
    t.string "name"
    t.text "description"
    t.text "image_url"
    t.string "address"
    t.string "status"
    t.integer "price"
    t.integer "rooms"
    t.integer "surface"
    t.integer "borough_id"
    t.boolean "balcony", default: false
    t.boolean "chimney", default: false
    t.boolean "elevator", default: false
    t.boolean "cellar", default: false
    t.boolean "parking", default: false
    t.boolean "terrace", default: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "city_id", null: false
    t.index ["city_id"], name: "index_apartments_on_city_id"
  end

  create_table "boroughs", force: :cascade do |t|
    t.string "name"
    t.string "insee_code"
    t.bigint "city_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["city_id"], name: "index_boroughs_on_city_id"
  end

  create_table "cities", force: :cascade do |t|
    t.string "name"
    t.string "insee_code"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "houses", force: :cascade do |t|
    t.bigint "city_id", null: false
    t.string "project"
    t.string "name"
    t.text "description"
    t.text "image_url"
    t.string "address"
    t.string "status"
    t.integer "price"
    t.integer "rooms"
    t.integer "surface"
    t.integer "borough_id"
    t.boolean "balcony", default: false
    t.boolean "chimney", default: false
    t.boolean "cellar", default: false
    t.boolean "parking", default: false
    t.boolean "terrace", default: false
    t.boolean "garden", default: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["city_id"], name: "index_houses_on_city_id"
  end

  add_foreign_key "apartments", "cities"
  add_foreign_key "boroughs", "cities"
  add_foreign_key "houses", "cities"
end
