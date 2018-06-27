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

ActiveRecord::Schema.define(version: 2018_06_26_002922) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "account_transactions", force: :cascade do |t|
    t.integer "transaction_type"
    t.string "transaction_code"
    t.decimal "amount", precision: 5, scale: 2, default: "0.0"
    t.integer "from_id"
    t.integer "to_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["from_id"], name: "index_account_transactions_on_from_id"
    t.index ["to_id"], name: "index_account_transactions_on_to_id"
    t.index ["transaction_code"], name: "index_account_transactions_on_transaction_code", unique: true
  end

  create_table "accounts", force: :cascade do |t|
    t.integer "account_type"
    t.integer "account_status"
    t.string "name"
    t.decimal "balance", precision: 5, scale: 2, default: "0.0", null: false
    t.string "ancestry"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["ancestry"], name: "index_accounts_on_ancestry"
  end

  create_table "people", force: :cascade do |t|
    t.string "type"
    t.string "cnpj"
    t.string "cpf"
    t.string "social_name"
    t.string "trade_name"
    t.string "full_name"
    t.date "birthdate"
    t.bigint "account_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["account_id"], name: "index_people_on_account_id"
    t.index ["type"], name: "index_people_on_type"
  end

  add_foreign_key "people", "accounts"
end
