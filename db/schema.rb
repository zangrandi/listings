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

ActiveRecord::Schema.define(version: 20180117012110) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "delayed_jobs", force: :cascade do |t|
    t.integer "priority", default: 0, null: false
    t.integer "attempts", default: 0, null: false
    t.text "handler", null: false
    t.text "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string "locked_by"
    t.string "queue"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["priority", "run_at"], name: "delayed_jobs_priority"
  end

  create_table "images", force: :cascade do |t|
    t.integer "listing_id"
    t.string "attachment_file_name"
    t.string "attachment_content_type"
    t.integer "attachment_file_size"
    t.datetime "attachment_updated_at"
    t.index ["listing_id"], name: "index_images_on_listing_id"
  end

  create_table "integrations", force: :cascade do |t|
    t.string "name"
    t.integer "user_id"
    t.string "username"
    t.string "password"
  end

  create_table "listing_integrations", force: :cascade do |t|
    t.integer "integration_id"
    t.integer "listing_id"
    t.string "identifier"
    t.string "type"
    t.index ["integration_id"], name: "index_listing_integrations_on_integration_id"
    t.index ["listing_id"], name: "index_listing_integrations_on_listing_id"
  end

  create_table "listings", force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.string "listing_type"
    t.integer "price", default: 0
    t.string "state"
    t.string "city"
    t.string "reference"
    t.integer "bedrooms", default: 0
    t.integer "bathrooms", default: 0
    t.integer "parking_spaces", default: 0
    t.integer "square_feet"
    t.string "district"
    t.string "zipcode"
    t.string "listing_subtype"
    t.string "transaction_type"
    t.string "street"
    t.string "number"
    t.string "complement"
    t.integer "suites", default: 0
    t.integer "user_id"
    t.string "phone"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
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

end
