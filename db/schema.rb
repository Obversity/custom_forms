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

ActiveRecord::Schema.define(version: 20151002073443) do

  create_table "field_options", force: :cascade do |t|
    t.string   "label"
    t.integer  "field_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "value"
  end

  create_table "field_validations", force: :cascade do |t|
    t.integer  "validation_id"
    t.integer  "field_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  create_table "fields", force: :cascade do |t|
    t.string   "field_type"
    t.string   "label"
    t.text     "hint"
    t.integer  "ordinal"
    t.boolean  "required"
    t.text     "placeholder"
    t.string   "class_name"
    t.string   "wrapper_class"
    t.integer  "form_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  create_table "forms", force: :cascade do |t|
    t.string   "title"
    t.text     "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "submissions", force: :cascade do |t|
    t.text     "data"
    t.string   "ip"
    t.integer  "form_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
