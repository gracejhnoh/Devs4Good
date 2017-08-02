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

ActiveRecord::Schema.define(version: 20170802185016) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "projects", force: :cascade do |t|
    t.integer "organization_id"
    t.text "description"
    t.date "time_frame"
    t.string "title"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "summary", null: false
    t.string "contact_email"
  end

  create_table "proposals", force: :cascade do |t|
    t.bigint "project_id"
    t.bigint "user_id"
    t.text "description"
    t.boolean "selected", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["project_id"], name: "index_proposals_on_project_id"
    t.index ["user_id"], name: "index_proposals_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "org_name"
    t.string "street_address"
    t.string "city"
    t.string "state"
    t.string "zip"
    t.string "phone"
    t.string "website"
    t.text "description"
    t.string "user_type", null: false
    t.string "email", null: false
    t.string "crypted_password", null: false
    t.string "salt"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "ein"
    t.string "image_uid"
    t.string "image_name"
    t.index ["email"], name: "index_users_on_email", unique: true
  end

  add_foreign_key "proposals", "projects"
  add_foreign_key "proposals", "users"
end
