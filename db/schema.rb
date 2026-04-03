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

ActiveRecord::Schema[8.1].define(version: 2026_04_03_152308) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "learning_records", force: :cascade do |t|
    t.text "content", null: false
    t.datetime "created_at", null: false
    t.integer "duration_minutes"
    t.bigint "learning_theme_id"
    t.date "study_date", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id", null: false
    t.index ["learning_theme_id"], name: "index_learning_records_on_learning_theme_id"
    t.index ["user_id"], name: "index_learning_records_on_user_id"
  end

  create_table "learning_themes", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "name"
    t.datetime "updated_at", null: false
    t.bigint "user_id", null: false
    t.index ["user_id", "name"], name: "index_learning_themes_on_user_id_and_name", unique: true, where: "(name IS NOT NULL)"
    t.index ["user_id"], name: "index_learning_themes_on_user_id"
  end

  create_table "record_tags", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.bigint "learning_record_id", null: false
    t.bigint "tag_id", null: false
    t.datetime "updated_at", null: false
    t.index ["learning_record_id", "tag_id"], name: "index_record_tags_on_learning_record_id_and_tag_id", unique: true
    t.index ["learning_record_id"], name: "index_record_tags_on_learning_record_id"
    t.index ["tag_id"], name: "index_record_tags_on_tag_id"
  end

  create_table "tags", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.bigint "learning_theme_id"
    t.string "name", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id", null: false
    t.index ["learning_theme_id"], name: "index_tags_on_learning_theme_id"
    t.index ["user_id", "name"], name: "index_tags_on_user_id_and_name", unique: true
    t.index ["user_id"], name: "index_tags_on_user_id"
  end

  create_table "todo_tags", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.bigint "tag_id", null: false
    t.bigint "todo_id", null: false
    t.datetime "updated_at", null: false
    t.index ["tag_id"], name: "index_todo_tags_on_tag_id"
    t.index ["todo_id", "tag_id"], name: "index_todo_tags_on_todo_id_and_tag_id", unique: true
    t.index ["todo_id"], name: "index_todo_tags_on_todo_id"
  end

  create_table "todos", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.text "description"
    t.boolean "is_completed", default: false, null: false
    t.bigint "learning_theme_id", null: false
    t.string "title"
    t.datetime "updated_at", null: false
    t.bigint "user_id", null: false
    t.index ["learning_theme_id"], name: "index_todos_on_learning_theme_id"
    t.index ["user_id"], name: "index_todos_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "crypted_password", null: false
    t.string "email", null: false
    t.string "name"
    t.string "remember_me_token"
    t.datetime "remember_me_token_expires_at"
    t.string "salt", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
  end

  add_foreign_key "learning_records", "learning_themes"
  add_foreign_key "learning_records", "users"
  add_foreign_key "learning_themes", "users", on_delete: :cascade
  add_foreign_key "record_tags", "learning_records"
  add_foreign_key "record_tags", "tags"
  add_foreign_key "tags", "learning_themes"
  add_foreign_key "tags", "users"
  add_foreign_key "todo_tags", "tags"
  add_foreign_key "todo_tags", "todos"
  add_foreign_key "todos", "learning_themes"
  add_foreign_key "todos", "users"
end
