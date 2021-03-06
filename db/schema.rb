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

ActiveRecord::Schema.define(:version => 20110327231957) do

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
    t.string   "mbid"
    t.string   "lang"
    t.string   "profile_image_file_name"
    t.integer  "profile_image_file_size"
    t.string   "profile_image_content_type"
    t.datetime "profile_image_updated_at"
  end

  create_table "authorizations", :force => true do |t|
    t.string   "provider"
    t.string   "uid"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "authorizations", ["user_id"], :name => "index_authorizations_on_user_id"

  create_table "background_stories", :force => true do |t|
    t.integer  "song_id"
    t.string   "title"
    t.text     "content"
    t.integer  "created_by_id"
    t.integer  "updated_by_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "beta_requests", :force => true do |t|
    t.string   "email"
    t.boolean  "is_sent"
    t.datetime "sent_at"
    t.boolean  "is_user"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "events", :force => true do |t|
    t.string   "title"
    t.string   "url"
    t.datetime "start_time"
    t.datetime "end_time"
    t.text     "detail"
    t.integer  "artist_id"
    t.integer  "created_by_id"
    t.integer  "updated_by_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "follows", :force => true do |t|
    t.integer  "followable_id",                      :null => false
    t.string   "followable_type",                    :null => false
    t.integer  "follower_id",                        :null => false
    t.string   "follower_type",                      :null => false
    t.boolean  "blocked",         :default => false, :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "follows", ["followable_id", "followable_type"], :name => "fk_followables"
  add_index "follows", ["follower_id", "follower_type"], :name => "fk_follows"

  create_table "lyrics", :force => true do |t|
    t.string   "song_title"
    t.string   "song_performer_name"
    t.text     "content"
    t.integer  "song_id"
    t.integer  "created_by_id"
    t.integer  "updated_by_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "notes", :force => true do |t|
    t.integer  "song_id"
    t.text     "content"
    t.integer  "created_by_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "notes", ["created_by_id"], :name => "index_notes_on_created_by_id"
  add_index "notes", ["song_id"], :name => "index_notes_on_song_id"

  create_table "participations", :force => true do |t|
    t.integer  "artist_id"
    t.integer  "song_id"
    t.string   "participation_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "queue_links", :force => true do |t|
    t.string   "artist_url"
    t.string   "artist_name"
    t.boolean  "imported"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "relationships", :force => true do |t|
    t.integer  "source_id"
    t.string   "source_type"
    t.integer  "target_id"
    t.string   "target_type"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "relationship_type"
  end

  add_index "relationships", ["source_type", "source_id", "relationship_type"], :name => "rel_source_type_index"
  add_index "relationships", ["target_id", "source_type", "relationship_type", "target_type"], :name => "rel_participant"
  add_index "relationships", ["target_id", "target_type", "relationship_type"], :name => "rel_target_type_index"

  create_table "releases", :force => true do |t|
    t.string   "release_type"
    t.string   "title"
    t.date     "release_date"
    t.string   "small_image_url"
    t.string   "medium_image_url"
    t.string   "large_image_url"
    t.string   "mbid"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "cover_image_file_name"
    t.integer  "cover_image_file_size"
    t.string   "cover_image_content_type"
    t.datetime "cover_image_updated_at"
    t.string   "artist_name"
  end

  create_table "requests", :force => true do |t|
    t.integer  "user_id"
    t.string   "query_url"
    t.string   "request_type"
    t.boolean  "resolved"
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

  create_table "songs", :force => true do |t|
    t.string   "title"
    t.string   "performer_name"
    t.string   "writer_name"
    t.text     "content"
    t.string   "album_name"
    t.string   "year"
    t.integer  "created_by_id"
    t.integer  "updated_by_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "video_url"
    t.string   "cover_url"
    t.datetime "lyrics_last_updated"
  end

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
    t.integer  "song_id"
    t.integer  "created_by_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "similarity"
    t.string   "title"
    t.boolean  "embeddable"
  end

  add_index "videos", ["song_id"], :name => "index_videos_on_song_id"

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
