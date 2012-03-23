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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20111213021445) do

  create_table "admins", :force => true do |t|
    t.string   "email",                                 :default => "", :null => false
    t.string   "encrypted_password",     :limit => 128, :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                         :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "admins", ["email"], :name => "index_admins_on_email", :unique => true
  add_index "admins", ["reset_password_token"], :name => "index_admins_on_reset_password_token", :unique => true

  create_table "bios", :force => true do |t|
    t.string   "name"
    t.string   "title"
    t.text     "content"
    t.string   "filename"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "position",   :limit => 255
    t.string   "image"
  end

  create_table "form_items", :force => true do |t|
    t.integer  "form_id"
    t.integer  "position"
    t.integer  "score"
    t.boolean  "checked"
    t.text     "content"
    t.string   "item_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "forms", :force => true do |t|
    t.integer  "position"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "itineraries", :force => true do |t|
    t.string   "title"
    t.text     "content"
    t.string   "image"
    t.integer  "position"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "page_snippets", :force => true do |t|
    t.integer  "page_id"
    t.text     "content"
    t.string   "title"
    t.string   "image"
    t.string   "slug"
    t.integer  "position"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "pages", :force => true do |t|
    t.integer  "snippet_id"
    t.integer  "position"
    t.string   "slug"
    t.string   "title"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "photos", :force => true do |t|
    t.string   "title"
    t.string   "filename"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "image"
    t.integer  "position"
  end

  create_table "quotations", :force => true do |t|
    t.text     "content"
    t.string   "signature"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "title"
    t.integer  "position",   :limit => 255
  end

  create_table "slide_photos", :force => true do |t|
    t.integer  "slide_id"
    t.integer  "position"
    t.string   "title"
    t.string   "image"
    t.string   "link"
    t.text     "content"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "slides", :force => true do |t|
    t.integer  "slideshow_id"
    t.integer  "position"
    t.string   "title"
    t.string   "link"
    t.text     "content"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "slideshows", :force => true do |t|
    t.integer  "position"
    t.string   "title"
    t.string   "link"
    t.text     "content"
    t.string   "slug"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
