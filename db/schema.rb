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

ActiveRecord::Schema[7.0].define(version: 2023_06_12_132654) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "administrators", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "classroom_id"
    t.index ["classroom_id"], name: "index_administrators_on_classroom_id"
    t.index ["user_id"], name: "index_administrators_on_user_id"
  end

  create_table "balances", force: :cascade do |t|
    t.decimal "withdrawn", precision: 8, scale: 2, default: "0.0", null: false
    t.decimal "balance_deposited", precision: 8, scale: 2, default: "0.0", null: false
    t.decimal "current_balance", precision: 8, scale: 2, default: "0.0", null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_balances_on_user_id"
  end

  create_table "classrooms", force: :cascade do |t|
    t.string "name", limit: 255, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "classrooms_users", id: false, force: :cascade do |t|
    t.bigint "classroom_id", null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["classroom_id", "user_id"], name: "index_classrooms_users_on_classroom_id_and_user_id", unique: true
  end

  create_table "fees", force: :cascade do |t|
    t.string "name", limit: 100, null: false
    t.float "value", null: false
    t.date "latest_release", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "investments", force: :cascade do |t|
    t.decimal "invested_amount", precision: 8, scale: 2
    t.date "investment_date"
    t.boolean "redeemed", default: false
    t.date "redemption_date"
    t.bigint "user_id", null: false
    t.bigint "product_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["product_id"], name: "index_investments_on_product_id"
    t.index ["user_id"], name: "index_investments_on_user_id"
  end

  create_table "investments_users", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "investment_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["investment_id"], name: "index_investments_users_on_investment_id"
    t.index ["user_id"], name: "index_investments_users_on_user_id"
  end

  create_table "products", force: :cascade do |t|
    t.string "name", null: false
    t.integer "punctuation", default: 0
    t.date "start_date", default: -> { "CURRENT_DATE" }
    t.date "end_of_term", null: false
    t.decimal "minimum_investment_amount", null: false
    t.string "image_url", null: false
    t.boolean "premium", default: false
    t.float "additional_fee", null: false
    t.bigint "fee_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["fee_id"], name: "index_products_on_fee_id"
  end

  create_table "transfers", force: :cascade do |t|
    t.bigint "sender_id", null: false
    t.bigint "receiver_id", null: false
    t.decimal "amount", precision: 8, scale: 2, default: "0.0", null: false
    t.string "token"
    t.integer "status", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "expires_at"
    t.index ["receiver_id"], name: "index_transfers_on_receiver_id"
    t.index ["sender_id"], name: "index_transfers_on_sender_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name", limit: 255, null: false
    t.string "cpf", limit: 11, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.bigint "classroom_id"
    t.index ["classroom_id"], name: "index_users_on_classroom_id"
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "administrators", "classrooms"
  add_foreign_key "administrators", "users"
  add_foreign_key "balances", "users"
  add_foreign_key "investments", "products"
  add_foreign_key "investments", "users"
  add_foreign_key "investments_users", "investments"
  add_foreign_key "investments_users", "users"
  add_foreign_key "products", "fees"
  add_foreign_key "users", "classrooms"
end
