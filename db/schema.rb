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

ActiveRecord::Schema[8.1].define(version: 2025_11_16_102738) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

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
end
