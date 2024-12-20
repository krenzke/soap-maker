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

ActiveRecord::Schema[7.2].define(version: 2024_12_20_212202) do
  create_table "batch_line_items", force: :cascade do |t|
    t.integer "ingredient_purchase_id"
    t.integer "batch_id"
    t.decimal "quantity_oz", null: false
    t.integer "seq"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["batch_id"], name: "index_batch_line_items_on_batch_id"
    t.index ["ingredient_purchase_id"], name: "index_batch_line_items_on_ingredient_purchase_id"
  end

  create_table "batches", force: :cascade do |t|
    t.date "manufactured_on", null: false
    t.string "name", null: false
    t.decimal "units_produced"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "ingredient_purchases", force: :cascade do |t|
    t.integer "ingredient_id"
    t.date "purchased_on", null: false
    t.decimal "total_quantity_oz", null: false
    t.decimal "total_cost", null: false
    t.string "source", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["ingredient_id"], name: "index_ingredient_purchases_on_ingredient_id"
  end

  create_table "ingredients", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "batch_line_items", "batches"
  add_foreign_key "batch_line_items", "ingredient_purchases"
  add_foreign_key "ingredient_purchases", "ingredients"
end