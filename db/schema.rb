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

ActiveRecord::Schema.define(version: 20141210213437) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "admins", force: true do |t|
    t.string   "admin_name"
    t.string   "email",                default: "", null: false
    t.string   "encrypted_password",   default: "", null: false
    t.integer  "sign_in_count",        default: 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.integer  "failed_attempts",      default: 0
    t.string   "unlock_token"
    t.datetime "locked_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
  end

  add_index "admins", ["email"], name: "index_admins_on_email", unique: true, using: :btree

  create_table "donations", force: true do |t|
    t.integer  "receipt_id"
    t.integer  "rider_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "mailing_addresses", force: true do |t|
    t.string   "line1"
    t.string   "line2"
    t.string   "city"
    t.string   "state"
    t.string   "zip"
    t.integer  "addressable_id"
    t.string   "addressable_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "receipts", force: true do |t|
    t.decimal  "amount",                 precision: 10, scale: 2, default: 0.0
    t.string   "paypal_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "reference_user_address",                          default: true
  end

  create_table "ride_years", force: true do |t|
    t.integer  "year"
    t.integer  "registration_fee"
    t.integer  "registration_fee_early"
    t.integer  "min_rider_fundraise"
    t.date     "early_bird_cutoff"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "current",                default: 0
    t.integer  "min_goal",               default: 2000
  end

  create_table "rider_regs", force: true do |t|
    t.integer  "rider_id"
    t.string   "ride_option"
    t.date     "birthdate"
    t.string   "primary_phone"
    t.string   "secondary_phone"
    t.boolean  "paid",                                        default: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.decimal  "goal",               precision: 10, scale: 2, default: 0.0
    t.decimal  "raised",             precision: 10, scale: 2, default: 0.0
    t.text     "bio"
    t.boolean  "accept_terms",                                default: false
    t.string   "photo_file_name"
    t.string   "photo_content_type"
    t.integer  "photo_file_size"
    t.datetime "photo_updated_at"
    t.integer  "ride_year_id"
  end

  create_table "users", force: true do |t|
    t.string   "title",                  default: ""
    t.string   "first_name"
    t.string   "last_name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
