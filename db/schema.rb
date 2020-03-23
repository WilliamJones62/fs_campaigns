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

ActiveRecord::Schema.define(version: 20200317121007) do

  create_table "campaign_activities", force: :cascade do |t|
    t.integer "customer_campaign_id"
    t.date "activity_date"
    t.string "activity"
    t.string "outcome"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "campaign_products", force: :cascade do |t|
    t.integer "campaign_id"
    t.string "part_code"
    t.string "part_desc"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "part_uom"
  end

  create_table "campaigns", force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.date "start_date"
    t.date "end_date"
  end

  create_table "customer_campaigns", force: :cascade do |t|
    t.string "custcode"
    t.string "custname"
    t.integer "campaign_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "user_name"
    t.string "campaign_title"
    t.boolean "active_campaign"
    t.boolean "three_orders"
    t.boolean "campaign_expired"
    t.string "ship_to"
  end

  create_table "customer_shiptos", force: :cascade do |t|
    t.string "cust_code"
    t.string "shipto_code"
    t.string "acct_manager"
    t.boolean "default_flag"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "orderfroms", force: :cascade do |t|
    t.string "cust_code"
    t.string "bus_name"
    t.string "cust_group"
    t.string "sales_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "partmstrs", force: :cascade do |t|
    t.string "part_code"
    t.string "part_desc"
    t.string "part_grp"
    t.string "uom"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "prospects", force: :cascade do |t|
    t.string "customer_id"
    t.string "name"
    t.string "credit_terms"
    t.string "rep"
    t.boolean "status"
    t.string "source"
    t.string "zip"
    t.date "active_date"
    t.boolean "customer"
    t.string "city"
    t.string "state"
    t.string "ship_to"
    t.boolean "compass"
    t.boolean "new_opening"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "campaigns"
    t.boolean "campaigns_admin"
    t.string "campaign_rep1"
    t.string "campaign_rep2"
    t.string "campaign_role"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

end
