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

ActiveRecord::Schema.define(version: 2019_03_31_131649) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "cvs", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "photo"
    t.string "phone_number"
    t.string "working_skills"
    t.date "birth_date"
    t.text "about"
    t.text "skills"
    t.text "future_plans"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "interests"
    t.string "headshot_file_name"
    t.string "headshot_content_type"
    t.bigint "headshot_file_size"
    t.datetime "headshot_updated_at"
    t.string "gender", limit: 1, default: "f"
    t.string "birth_place"
    t.index ["user_id"], name: "index_cvs_on_user_id"
  end

  create_table "educations", force: :cascade do |t|
    t.bigint "cv_id", null: false
    t.date "started_on"
    t.date "ended_on"
    t.string "degree"
    t.string "school", null: false
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["cv_id"], name: "index_educations_on_cv_id"
  end

  create_table "experiences", force: :cascade do |t|
    t.bigint "cv_id", null: false
    t.date "started_on"
    t.date "ended_on"
    t.string "company", null: false
    t.string "location"
    t.string "title", null: false
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["cv_id"], name: "index_experiences_on_cv_id"
  end

  create_table "languages", force: :cascade do |t|
    t.bigint "cv_id", null: false
    t.string "language", null: false
    t.string "level"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["cv_id"], name: "index_languages_on_cv_id"
  end

  create_table "locations", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.float "latitude"
    t.float "longitude"
    t.integer "radius"
    t.string "city"
    t.string "country"
    t.string "geocoded_address"
    t.string "original_address", null: false
    t.string "province_code"
    t.string "region"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_locations_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "first_name", null: false
    t.string "last_name", null: false
    t.string "email", null: false
    t.string "encrypted_password", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "cvs", "users"
  add_foreign_key "educations", "cvs"
  add_foreign_key "experiences", "cvs"
  add_foreign_key "languages", "cvs"
  add_foreign_key "locations", "users"
end
