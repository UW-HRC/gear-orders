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

ActiveRecord::Schema.define(version: 20171202092547) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "gear_sales", force: :cascade do |t|
    t.string "name"
    t.date "close_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "item_sizes", force: :cascade do |t|
    t.string "name"
    t.decimal "price", precision: 10, scale: 2
    t.integer "quantity"
    t.boolean "has_quantity"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "item_id"
    t.index ["item_id"], name: "index_item_sizes_on_item_id"
  end

  create_table "items", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "orders", force: :cascade do |t|
    t.decimal "amount_paid", precision: 10, scale: 2, default: "0.0"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "confirmed", default: false
    t.string "first_name"
    t.string "last_name"
    t.string "email"
  end

  create_table "purchases", force: :cascade do |t|
    t.integer "quantity"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "item_size_id"
    t.bigint "order_id"
    t.index ["item_size_id"], name: "index_purchases_on_item_size_id"
    t.index ["order_id"], name: "index_purchases_on_order_id"
  end

end
