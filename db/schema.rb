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

ActiveRecord::Schema.define(version: 2022_09_06_135750) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "apartments", force: :cascade do |t|
    t.string "project"
    t.text "description"
    t.text "image_url"
    t.string "address"
    t.string "status"
    t.integer "floor"
    t.integer "building_floor"
    t.integer "price"
    t.integer "rooms"
    t.integer "bedrooms"
    t.integer "surface"
    t.boolean "balcony", default: false
    t.boolean "chimney", default: false
    t.boolean "elevator", default: false
    t.boolean "cellar", default: false
    t.boolean "garage", default: false
    t.boolean "terrace", default: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "city_id", null: false
    t.bigint "borough_id"
    t.float "latitude"
    t.float "longitude"
    t.index ["borough_id"], name: "index_apartments_on_borough_id"
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

  create_table "favorite_apartments", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "apartment_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["apartment_id"], name: "index_favorite_apartments_on_apartment_id"
    t.index ["user_id"], name: "index_favorite_apartments_on_user_id"
  end

  create_table "favorite_houses", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "house_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["house_id"], name: "index_favorite_houses_on_house_id"
    t.index ["user_id"], name: "index_favorite_houses_on_user_id"
  end

  create_table "houses", force: :cascade do |t|
    t.bigint "city_id", null: false
    t.string "project"
    t.text "description"
    t.text "image_url"
    t.string "address"
    t.string "status"
    t.integer "price"
    t.integer "rooms"
    t.integer "bedrooms"
    t.integer "surface"
    t.boolean "balcony", default: false
    t.boolean "chimney", default: false
    t.boolean "cellar", default: false
    t.boolean "garage", default: false
    t.boolean "terrace", default: false
    t.boolean "garden", default: false
    t.boolean "pool", default: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "borough_id"
    t.float "latitude"
    t.float "longitude"
    t.index ["borough_id"], name: "index_houses_on_borough_id"
    t.index ["city_id"], name: "index_houses_on_city_id"
  end

  create_table "research_boroughs", force: :cascade do |t|
    t.bigint "borough_id", null: false
    t.bigint "research_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["borough_id"], name: "index_research_boroughs_on_borough_id"
    t.index ["research_id"], name: "index_research_boroughs_on_research_id"
  end

  create_table "research_cities", force: :cascade do |t|
    t.bigint "city_id", null: false
    t.bigint "research_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["city_id"], name: "index_research_cities_on_city_id"
    t.index ["research_id"], name: "index_research_cities_on_research_id"
  end

  create_table "researches", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "city_id"
    t.bigint "borough_id"
    t.text "link"
    t.string "types"
    t.string "rooms"
    t.string "bedrooms"
    t.string "project"
    t.string "type"
    t.string "locations"
    t.string "status"
    t.string "floor"
    t.boolean "balcony", default: false
    t.boolean "chimney", default: false
    t.boolean "pool", default: false
    t.boolean "garden", default: false
    t.boolean "cellar", default: false
    t.boolean "garage", default: false
    t.boolean "terrace", default: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["borough_id"], name: "index_researches_on_borough_id"
    t.index ["city_id"], name: "index_researches_on_city_id"
    t.index ["user_id"], name: "index_researches_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "apartments", "boroughs"
  add_foreign_key "apartments", "cities"
  add_foreign_key "boroughs", "cities"
  add_foreign_key "favorite_apartments", "apartments"
  add_foreign_key "favorite_apartments", "users"
  add_foreign_key "favorite_houses", "houses"
  add_foreign_key "favorite_houses", "users"
  add_foreign_key "houses", "boroughs"
  add_foreign_key "houses", "cities"
  add_foreign_key "research_boroughs", "boroughs"
  add_foreign_key "research_boroughs", "researches"
  add_foreign_key "research_cities", "cities"
  add_foreign_key "research_cities", "researches"
  add_foreign_key "researches", "boroughs"
  add_foreign_key "researches", "cities"
  add_foreign_key "researches", "users"
end
