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

ActiveRecord::Schema.define(version: 20190427203312) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "gear_sales", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "active", default: false
    t.boolean "open", default: false
    t.text "status", default: ""
  end

  create_table "items", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "photo"
    t.decimal "price", precision: 10, scale: 2
    t.bigint "gear_sale_id"
    t.index ["gear_sale_id"], name: "index_items_on_gear_sale_id"
  end

  create_table "items_sizes", force: :cascade do |t|
    t.bigint "item_id"
    t.bigint "size_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["item_id"], name: "index_items_sizes_on_item_id"
    t.index ["size_id"], name: "index_items_sizes_on_size_id"
  end

  create_table "loan_items", force: :cascade do |t|
    t.string "name"
    t.integer "inventory_number"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id"
    t.index ["user_id"], name: "index_loan_items_on_user_id"
  end

  create_table "loan_status_updates", force: :cascade do |t|
    t.bigint "loan_item_id"
    t.bigint "user_id"
    t.integer "status"
    t.text "notes"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "old_user_id"
    t.bigint "author_id"
    t.index ["author_id"], name: "index_loan_status_updates_on_author_id"
    t.index ["loan_item_id"], name: "index_loan_status_updates_on_loan_item_id"
    t.index ["old_user_id"], name: "index_loan_status_updates_on_old_user_id"
    t.index ["user_id"], name: "index_loan_status_updates_on_user_id"
  end

  create_table "orders", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "confirmed", default: false
    t.boolean "fulfilled", default: false
    t.bigint "gear_sale_id"
    t.bigint "user_id", null: false
    t.index ["gear_sale_id", "user_id"], name: "index_orders_on_gear_sale_id_and_user_id", unique: true
    t.index ["gear_sale_id"], name: "index_orders_on_gear_sale_id"
    t.index ["user_id"], name: "index_orders_on_user_id"
  end

  create_table "payments", force: :cascade do |t|
    t.bigint "order_id"
    t.decimal "amount", precision: 10, scale: 2
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "method"
    t.index ["order_id"], name: "index_payments_on_order_id"
  end

  create_table "purchases", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "order_id"
    t.bigint "item_id"
    t.bigint "size_id"
    t.index ["item_id"], name: "index_purchases_on_item_id"
    t.index ["order_id"], name: "index_purchases_on_order_id"
    t.index ["size_id"], name: "index_purchases_on_size_id"
  end

  create_table "sizes", force: :cascade do |t|
    t.string "size"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
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
    t.integer "role", default: 0
    t.string "full_name"
    t.string "preferred_name"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "items", "gear_sales"
  add_foreign_key "items_sizes", "items"
  add_foreign_key "items_sizes", "sizes"
  add_foreign_key "loan_status_updates", "loan_items"
  add_foreign_key "loan_status_updates", "users"
  add_foreign_key "loan_status_updates", "users", column: "author_id"
  add_foreign_key "loan_status_updates", "users", column: "old_user_id"
  add_foreign_key "orders", "gear_sales"
  add_foreign_key "orders", "users"
  add_foreign_key "payments", "orders"
  add_foreign_key "purchases", "items"
  add_foreign_key "purchases", "sizes"
end
