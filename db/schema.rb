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

ActiveRecord::Schema.define(version: 2018_10_17_123210) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "authors", id: :serial, force: :cascade do |t|
    t.string "first_name", null: false
    t.string "middle_name", null: false
    t.string "last_name", null: false
    t.string "search_name", null: false
  end

  create_table "books", id: :serial, force: :cascade do |t|
    t.integer "author_id"
    t.string "filename", null: false
    t.string "title", null: false
    t.integer "d_count", default: 0, null: false
    t.index ["author_id"], name: "index_books_on_author_id"
  end

  create_table "messages", id: :serial, force: :cascade do |t|
    t.string "zapros", null: false
    t.string "href", null: false
    t.jsonb "data", null: false
    t.integer "user_id"
    t.integer "chat_id"
    t.string "username"
    t.string "first_name"
    t.string "last_name"
    t.string "text"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "mixes", id: :serial, force: :cascade do |t|
    t.string "author_name", null: false
    t.string "book_title", null: false
    t.string "search_field", null: false
    t.string "filename", null: false
    t.string "author_id", null: false
    t.string "book_id", null: false
  end

  create_table "pg_search_documents", id: :serial, force: :cascade do |t|
    t.text "content"
    t.string "searchable_type"
    t.integer "searchable_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["searchable_type", "searchable_id"], name: "index_pg_search_documents_on_searchable_type_and_searchable_id"
  end

  create_table "songs", id: :serial, force: :cascade do |t|
    t.string "author", null: false
    t.string "track", null: false
    t.string "href", null: false
    t.string "filename", null: false
  end

end
