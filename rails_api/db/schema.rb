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

ActiveRecord::Schema[7.0].define(version: 2022_09_02_114305) do
  create_table "authors", charset: "utf8", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "books", charset: "utf8", force: :cascade do |t|
    t.string "title", null: false
    t.string "author", null: false
    t.integer "price", null: false
    t.datetime "created_at", precision: nil, default: -> { "CURRENT_TIMESTAMP" }
    t.datetime "updated_at", precision: nil, default: -> { "CURRENT_TIMESTAMP" }
  end

  create_table "comments", charset: "utf8", force: :cascade do |t|
    t.bigint "book_id", null: false
    t.string "text", null: false
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.index ["book_id"], name: "index_comments_on_book_id"
  end

  create_table "user_profiles", charset: "utf8", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "self_introduction", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_user_profiles_on_user_id"
  end

  create_table "users", charset: "utf8", force: :cascade do |t|
    t.string "name"
    t.integer "age"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "comments", "books"
  add_foreign_key "user_profiles", "users"
end
