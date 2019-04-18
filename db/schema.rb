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

ActiveRecord::Schema.define(version: 2019_04_18_201450) do

  create_table "ingredients", force: :cascade do |t|
    t.string "title"
    t.decimal "quantity"
    t.string "unit"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["title", "quantity", "unit"], name: "index_ingredients_on_title_and_quantity_and_unit", unique: true
  end

  create_table "ingredients_recipes", id: false, force: :cascade do |t|
    t.integer "ingredient_id", null: false
    t.integer "recipe_id", null: false
    t.index ["ingredient_id", "recipe_id"], name: "index_ingredients_recipes_on_ingredient_id_and_recipe_id", unique: true
  end

  create_table "ingredients_upcs", id: false, force: :cascade do |t|
    t.integer "ingredient_id", null: false
    t.integer "upc_id", null: false
    t.index ["ingredient_id", "upc_id"], name: "index_ingredients_upcs_on_ingredient_id_and_upc_id", unique: true
  end

  create_table "recipes", force: :cascade do |t|
    t.string "name"
    t.string "raw_text"
    t.string "url"
    t.string "image"
    t.decimal "rating"
    t.string "source"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name", "raw_text", "url", "image", "rating", "source"], name: "recipes_unique", unique: true
  end

  create_table "upcs", force: :cascade do |t|
    t.string "upc_string"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["upc_string"], name: "index_upcs_on_upc_string", unique: true
  end

  create_table "user_ingredients", force: :cascade do |t|
    t.string "quantity_left"
    t.string "quantity_left_unit"
    t.integer "user_id"
    t.integer "ingredient_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["ingredient_id"], name: "index_user_ingredients_on_ingredient_id"
    t.index ["quantity_left", "quantity_left_unit", "user_id", "ingredient_id"], name: "user_ingredients_unique", unique: true
    t.index ["user_id"], name: "index_user_ingredients_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "password_digest"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name", "email"], name: "index_users_on_name_and_email", unique: true
  end

end
