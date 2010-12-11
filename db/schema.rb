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

ActiveRecord::Schema.define(:version => 20101211180838) do

  create_table "artists", :force => true do |t|
    t.string   "name"
    t.string   "full_name"
    t.string   "artist_type"
    t.string   "primary_position"
    t.string   "secondary_position"
    t.text     "bio_summary"
    t.text     "bio_full"
    t.string   "image_small_url"
    t.string   "image_large_url"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "authorizations", :force => true do |t|
    t.string   "provider"
    t.string   "uid"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "background_stories", :force => true do |t|
    t.integer  "lyric_id"
    t.string   "title"
    t.text     "content"
    t.integer  "created_by_id"
    t.integer  "updated_by_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "lyrics", :force => true do |t|
    t.string   "title"
    t.string   "performer_name"
    t.string   "writer_name"
    t.text     "content"
    t.string   "album_name"
    t.integer  "year"
    t.integer  "created_by_id"
    t.integer  "updated_by_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "video_url"
    t.string   "cover_url"
  end

  create_table "notes", :force => true do |t|
    t.integer  "lyric_id"
    t.text     "content"
    t.integer  "created_by_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "participations", :force => true do |t|
    t.integer  "artist_id"
    t.integer  "lyric_id"
    t.string   "participation_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "slugs", :force => true do |t|
    t.string   "name"
    t.integer  "sluggable_id"
    t.integer  "sequence",                     :default => 1, :null => false
    t.string   "sluggable_type", :limit => 40
    t.string   "scope"
    t.datetime "created_at"
  end

  add_index "slugs", ["name", "sluggable_type", "sequence", "scope"], :name => "index_slugs_on_n_s_s_and_s", :unique => true
  add_index "slugs", ["sluggable_id"], :name => "index_slugs_on_sluggable_id"

  create_table "users", :force => true do |t|
    t.string   "username",                           :null => false
    t.string   "email"
    t.string   "crypted_password"
    t.string   "password_salt"
    t.string   "persistence_token"
    t.string   "single_access_token"
    t.string   "perishable_token"
    t.integer  "login_count",         :default => 0, :null => false
    t.integer  "failed_login_count",  :default => 0, :null => false
    t.datetime "last_request_at"
    t.datetime "current_login_at"
    t.datetime "last_login_at"
    t.string   "current_login_ip"
    t.string   "last_login_ip"
    t.boolean  "admin"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
  end

  add_index "users", ["username"], :name => "index_users_on_username", :unique => true

  create_table "videos", :force => true do |t|
    t.string   "uid"
    t.string   "url"
    t.string   "source"
    t.integer  "lyric_id"
    t.integer  "created_by_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "votes", :force => true do |t|
    t.boolean  "vote",          :default => false
    t.integer  "voteable_id",                      :null => false
    t.string   "voteable_type",                    :null => false
    t.integer  "voter_id"
    t.string   "voter_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "votes", ["voteable_id", "voteable_type"], :name => "fk_voteables"
  add_index "votes", ["voter_id", "voter_type", "voteable_id", "voteable_type"], :name => "uniq_one_vote_only", :unique => true
  add_index "votes", ["voter_id", "voter_type"], :name => "fk_voters"

end
