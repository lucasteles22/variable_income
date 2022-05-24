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

ActiveRecord::Schema[7.0].define(version: 2022_05_24_003441) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  # Custom types defined in this database.
  # Note that some types may not work with other database engines. Be careful if changing database.
  create_enum "kind", ["dividend", "interest_on_equity", "income"]

  create_table "allowlisted_jwts", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "jti", null: false
    t.string "aud", null: false
    t.datetime "exp", null: false
    t.string "remote_ip"
    t.string "os_data"
    t.string "browser_data"
    t.string "device_data"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["jti"], name: "index_allowlisted_jwts_on_jti", unique: true
    t.index ["user_id"], name: "index_allowlisted_jwts_on_user_id"
  end

  create_table "assets", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_assets_on_name", unique: true
  end

  create_table "earnings", force: :cascade do |t|
    t.bigint "asset_id", null: false
    t.bigint "user_id", null: false
    t.enum "kind", null: false, enum_type: "kind"
    t.date "paid_at", null: false
    t.integer "quantity", null: false
    t.decimal "unit_price", precision: 8, scale: 2, null: false
    t.decimal "net_value", precision: 8, scale: 2, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["asset_id"], name: "index_earnings_on_asset_id"
    t.index ["user_id"], name: "index_earnings_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "first_name", null: false
    t.string "last_name", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "allowlisted_jwts", "users", on_delete: :cascade
  add_foreign_key "earnings", "assets"
  add_foreign_key "earnings", "users"
end
