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
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20150713081909) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "admin_profiles", force: true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "gsm"
    t.integer  "admin_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "admin_profiles", ["admin_id"], name: "index_admin_profiles_on_admin_id", using: :btree

  create_table "admins", force: true do |t|
    t.string   "email",                  default: "",    null: false
    t.string   "encrypted_password",     default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "blocked",                default: false
    t.string   "locale",                 default: "tr"
  end

  add_index "admins", ["email"], name: "index_admins_on_email", unique: true, using: :btree
  add_index "admins", ["reset_password_token"], name: "index_admins_on_reset_password_token", unique: true, using: :btree

  create_table "astroturves", force: true do |t|
    t.integer "company_id"
    t.string  "name"
    t.string  "longitude"
    t.string  "latitude"
    t.string  "address"
    t.string  "phone"
    t.integer "city_id"
    t.integer "town_id"
    t.decimal "week_price",    precision: 7, scale: 2
    t.decimal "weekend_price", precision: 7, scale: 2
  end

  add_index "astroturves", ["city_id"], name: "index_astroturves_on_city_id", using: :btree
  add_index "astroturves", ["company_id"], name: "index_astroturves_on_company_id", using: :btree
  add_index "astroturves", ["town_id"], name: "index_astroturves_on_town_id", using: :btree

  create_table "cities", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "companies", force: true do |t|
    t.string   "email",                  default: "",    null: false
    t.string   "encrypted_password",     default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "locale",                 default: "tr"
    t.string   "time_zone"
    t.boolean  "blocked",                default: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "companies", ["email"], name: "index_companies_on_email", unique: true, using: :btree
  add_index "companies", ["reset_password_token"], name: "index_companies_on_reset_password_token", unique: true, using: :btree

  create_table "company_profiles", force: true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "gsm"
    t.integer  "company_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "title",      default: ""
  end

  add_index "company_profiles", ["company_id"], name: "index_company_profiles_on_company_id", using: :btree

  create_table "towns", force: true do |t|
    t.integer  "city_id"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "user_profiles", force: true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "gsm"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "user_profiles", ["user_id"], name: "index_user_profiles_on_user_id", using: :btree

  create_table "users", force: true do |t|
    t.string   "email",                  default: "",    null: false
    t.string   "encrypted_password",     default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "time_zone"
    t.boolean  "blocked",                default: false
    t.string   "locale",                 default: "tr"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
