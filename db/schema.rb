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

ActiveRecord::Schema.define(version: 20150123195641) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "blacklist_reasons", force: true do |t|
    t.string "reason", null: false
  end

  create_table "flagged_users", force: true do |t|
    t.integer  "user_id",            limit: 8, null: false
    t.integer  "userid_flagged",     limit: 8, null: false
    t.integer  "flagging_reason_id",           null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "flagging_reasons", force: true do |t|
    t.string "reason", null: false
  end

  create_table "quizzes", force: true do |t|
    t.integer "category", default: 1,  null: false
    t.string  "question", default: "", null: false
    t.string  "choice1",  default: "", null: false
    t.string  "choice2",  default: "", null: false
    t.string  "choice3",  default: "", null: false
    t.string  "choice4",  default: "", null: false
  end

  create_table "user_blacklists", force: true do |t|
    t.integer  "user_id",             limit: 8, null: false
    t.integer  "userid_blacklisted",  limit: 8, null: false
    t.integer  "blacklist_reason_id",           null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "user_match_statuses", force: true do |t|
    t.string   "status",     null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "user_matches", force: true do |t|
    t.integer  "user_id",              limit: 8, null: false
    t.integer  "userid_matched",       limit: 8, null: false
    t.integer  "user_match_status_id"
    t.datetime "expiry_time"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "user_messages", force: true do |t|
    t.integer  "user_id",        limit: 8, null: false
    t.integer  "userid_sent_to", limit: 8, null: false
    t.string   "message",                  null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "user_pictures", force: true do |t|
    t.integer  "user_id",       limit: 8,                 null: false
    t.integer  "display_order",           default: 0,     null: false
    t.boolean  "is_private",              default: false, null: false
    t.string   "photo_token",             default: "",    null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "user_preferences", force: true do |t|
    t.integer  "user_id",    limit: 8,              null: false
    t.integer  "distance",                          null: false
    t.string   "movie",                default: [],              array: true
    t.string   "music",                default: [],              array: true
    t.string   "activity",             default: [],              array: true
    t.string   "food",                 default: [],              array: true
    t.string   "language",             default: [],              array: true
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "user_profiles", force: true do |t|
    t.integer  "user_id",       limit: 8,                         null: false
    t.string   "user_name",                                       null: false
    t.integer  "birth_year",                                      null: false
    t.string   "sex",                                             null: false
    t.string   "sex_preferred",                                   null: false
    t.decimal  "height",                  precision: 3, scale: 1, null: false
    t.decimal  "weight",                  precision: 3, scale: 1, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "user_quiz_selections", force: true do |t|
    t.integer  "user_id",          limit: 8
    t.integer  "quiz_id"
    t.integer  "userid_selected",  limit: 8, null: false
    t.integer  "selector_choice",            null: false
    t.integer  "responder_choice",           null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "user_ratings", force: true do |t|
    t.integer  "user_id",            limit: 8, null: false
    t.integer  "userid_ratingsfrom", limit: 8, null: false
    t.boolean  "funny"
    t.boolean  "smart"
    t.boolean  "friendly"
    t.boolean  "interesting"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "user_types", force: true do |t|
    t.string "user_type"
  end

  create_table "users", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "authentication_token"
    t.integer  "user_type_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["authentication_token"], name: "index_users_on_authentication_token", unique: true, using: :btree
  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
