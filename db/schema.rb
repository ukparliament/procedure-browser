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

ActiveRecord::Schema[8.1].define(version: 2026_01_30_114439) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "enabling_legislations", force: :cascade do |t|
    t.integer "act_number"
    t.datetime "created_at", null: false
    t.date "date"
    t.text "identifier"
    t.text "label"
    t.datetime "updated_at", null: false
    t.text "uri"
    t.integer "year"
  end

  create_table "organisations_accountable_to_parliament", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.date "end_on"
    t.text "identifier"
    t.text "label"
    t.date "start_on"
    t.datetime "updated_at", null: false
  end

  create_table "pg_search_documents", force: :cascade do |t|
    t.text "content"
    t.datetime "created_at", null: false
    t.bigint "searchable_id"
    t.string "searchable_type"
    t.datetime "updated_at", null: false
    t.index ["searchable_type", "searchable_id"], name: "index_pg_search_documents_on_searchable"
  end

  create_table "work_packages", force: :cascade do |t|
    t.text "calculation_style_identifier"
    t.text "calculation_style_label"
    t.datetime "created_at", null: false
    t.text "has_committee_concerns"
    t.text "has_motion_tabled"
    t.text "identifier"
    t.date "made_available_on"
    t.text "making_available_identifier"
    t.text "procedure_identifier"
    t.text "procedure_label"
    t.datetime "updated_at", null: false
    t.text "work_packageable_thing_identifer"
    t.text "work_packageable_thing_label"
  end
end
