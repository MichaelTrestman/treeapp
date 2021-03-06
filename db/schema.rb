# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20150123002955) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "authors", force: true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "authorships", force: true do |t|
    t.integer "author_id"
    t.integer "publication_id"
  end

  create_table "contributors", force: true do |t|
    t.string   "name",            null: false
    t.string   "email",           null: false
    t.string   "password_digest", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "publications", force: true do |t|
    t.string   "title"
    t.string   "date"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "citation_count"
    t.integer  "year"
    t.text     "abstract"
    t.text     "body"
    t.text     "bibliography"
    t.text     "url"
  end

  create_table "tags", force: true do |t|
    t.integer "topic_id"
    t.integer "publication_id"
  end

  create_table "taxons", force: true do |t|
    t.string "scientific_name"
    t.string "common_name"
    t.text   "link_urls"
  end

  create_table "topics", force: true do |t|
    t.string   "title"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "trait_attributions", force: true do |t|
    t.integer "trait_id"
    t.integer "taxon_id"
    t.integer "publication_id"
    t.text    "reference"
  end

  create_table "traits", force: true do |t|
    t.string "name"
    t.text   "description"
    t.text   "link_urls"
  end

end
