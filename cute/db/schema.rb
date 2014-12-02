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

ActiveRecord::Schema.define(version: 20141202211402) do

  create_table "images", force: true do |t|
    t.string   "filename"
    t.integer  "cute_vote"
    t.integer  "total_vote"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "images", ["user_id"], name: "index_images_on_user_id"

  create_table "posts", force: true do |t|
    t.string   "comment"
    t.integer  "image_id"
    t.integer  "user_id"
    t.datetime "posted"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "posts", ["image_id"], name: "index_posts_on_image_id"
  add_index "posts", ["user_id"], name: "index_posts_on_user_id"

end