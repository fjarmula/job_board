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

ActiveRecord::Schema[8.1].define(version: 2025_11_17_114655) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "job_applications", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.bigint "job_offer_id", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id", null: false
    t.index ["job_offer_id"], name: "index_job_applications_on_job_offer_id"
    t.index ["user_id"], name: "index_job_applications_on_user_id"
  end

  create_table "job_offers", force: :cascade do |t|
    t.string "company_name"
    t.datetime "created_at", null: false
    t.text "description"
    t.integer "employment_type"
    t.integer "experience_level"
    t.string "location"
    t.string "position"
    t.decimal "salary_max"
    t.decimal "salary_min"
    t.text "tech_stack"
    t.datetime "updated_at", null: false
    t.integer "work_dimension"
    t.integer "work_mode"
  end

  create_table "sessions", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "ip_address"
    t.datetime "updated_at", null: false
    t.string "user_agent"
    t.bigint "user_id", null: false
    t.index ["user_id"], name: "index_sessions_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "email_address"
    t.string "password_digest"
    t.datetime "updated_at", null: false
    t.string "username"
  end

  add_foreign_key "job_applications", "job_offers"
  add_foreign_key "job_applications", "users"
  add_foreign_key "sessions", "users"
end
