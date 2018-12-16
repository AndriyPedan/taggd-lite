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

ActiveRecord::Schema.define(version: 2018_12_10_164829) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "media", force: :cascade do |t|
    t.string "type"
    t.string "media_url"
    t.integer "status", default: 0
    t.string "created_time"
    t.string "permalink"
    t.string "like_count"
    t.string "comments_count"
    t.string "instagram_id"
    t.string "thumbnail_url"
    t.string "username"
    t.string "caption"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "media_type"
    t.bigint "retailer_id"
    t.index ["retailer_id"], name: "index_media_on_retailer_id"
  end

  create_table "retailers", force: :cascade do |t|
    t.string "username"
    t.string "name"
    t.string "business_id"
    t.string "token"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "current"
    t.index ["user_id"], name: "index_retailers_on_user_id"
  end

  create_table "subscriptions", force: :cascade do |t|
    t.bigint "retailer_id"
    t.string "plan_token", null: false
    t.string "card_token"
    t.string "customer_token"
    t.integer "plan_type"
    t.boolean "active", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "subscription_token"
    t.index ["retailer_id"], name: "index_subscriptions_on_retailer_id", unique: true
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "provider"
    t.string "uid"
    t.string "token"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "media", "retailers"
end
