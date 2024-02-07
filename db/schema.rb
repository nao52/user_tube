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

ActiveRecord::Schema[7.0].define(version: 2024_02_07_073243) do
  create_table "best_channels", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "channel_id", null: false
    t.integer "rank", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["channel_id"], name: "index_best_channels_on_channel_id"
    t.index ["user_id", "channel_id"], name: "index_best_channels_on_user_id_and_channel_id", unique: true
    t.index ["user_id", "rank"], name: "index_best_channels_on_user_id_and_rank", unique: true
    t.index ["user_id"], name: "index_best_channels_on_user_id"
  end

  create_table "best_channels_favorites", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "best_channel_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["best_channel_id"], name: "index_best_channels_favorites_on_best_channel_id"
    t.index ["user_id", "best_channel_id"], name: "index_best_channels_favorites_on_user_id_and_best_channel_id", unique: true
    t.index ["user_id"], name: "index_best_channels_favorites_on_user_id"
  end

  create_table "best_videos", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "video_id", null: false
    t.integer "rank", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id", "rank"], name: "index_best_videos_on_user_id_and_rank", unique: true
    t.index ["user_id", "video_id"], name: "index_best_videos_on_user_id_and_video_id", unique: true
    t.index ["user_id"], name: "index_best_videos_on_user_id"
    t.index ["video_id"], name: "index_best_videos_on_video_id"
  end

  create_table "best_videos_favorites", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "best_video_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["best_video_id"], name: "index_best_videos_favorites_on_best_video_id"
    t.index ["user_id", "best_video_id"], name: "index_best_videos_favorites_on_user_id_and_best_video_id", unique: true
    t.index ["user_id"], name: "index_best_videos_favorites_on_user_id"
  end

  create_table "categories", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.integer "title", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["title"], name: "index_categories_on_title", unique: true
  end

  create_table "channel_comments", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.text "body", null: false
    t.bigint "user_id", null: false
    t.bigint "channel_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["channel_id"], name: "index_channel_comments_on_channel_id"
    t.index ["user_id"], name: "index_channel_comments_on_user_id"
  end

  create_table "channel_playlist_videos", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "channel_playlist_id", null: false
    t.bigint "video_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["channel_playlist_id"], name: "index_channel_playlist_videos_on_channel_playlist_id"
    t.index ["video_id"], name: "index_channel_playlist_videos_on_video_id"
  end

  create_table "channel_playlists", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "channel_id", null: false
    t.string "playlist_id"
    t.string "title"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["channel_id"], name: "index_channel_playlists_on_channel_id"
    t.index ["playlist_id"], name: "index_channel_playlists_on_playlist_id", unique: true
  end

  create_table "channels", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "channel_id", null: false
    t.string "thumbnail_url"
    t.string "name", null: false
    t.integer "subscriber_count", null: false
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["channel_id"], name: "index_channels_on_channel_id", unique: true
  end

  create_table "content_comments", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.text "body", null: false
    t.bigint "user_id", null: false
    t.bigint "content_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["content_id"], name: "index_content_comments_on_content_id"
    t.index ["user_id"], name: "index_content_comments_on_user_id"
  end

  create_table "content_favorites", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "content_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["content_id"], name: "index_content_favorites_on_content_id"
    t.index ["user_id", "content_id"], name: "index_content_favorites_on_user_id_and_content_id", unique: true
    t.index ["user_id"], name: "index_content_favorites_on_user_id"
  end

  create_table "contents", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "video_url", null: false
    t.integer "rating", null: false
    t.text "feedback", null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "video_id", null: false
    t.index ["user_id"], name: "index_contents_on_user_id"
    t.index ["video_id"], name: "index_contents_on_video_id"
  end

  create_table "popular_videos", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "video_id", null: false
    t.boolean "is_public", default: false, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_popular_videos_on_user_id"
    t.index ["video_id"], name: "index_popular_videos_on_video_id"
  end

  create_table "relationships", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.integer "follower_id"
    t.integer "followed_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["followed_id"], name: "index_relationships_on_followed_id"
    t.index ["follower_id", "followed_id"], name: "index_relationships_on_follower_id_and_followed_id", unique: true
    t.index ["follower_id"], name: "index_relationships_on_follower_id"
  end

  create_table "subscription_channels", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "channel_id", null: false
    t.boolean "is_public", default: false, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["channel_id"], name: "index_subscription_channels_on_channel_id"
    t.index ["user_id"], name: "index_subscription_channels_on_user_id"
  end

  create_table "user_categories", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "category_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["category_id"], name: "index_user_categories_on_category_id"
    t.index ["user_id", "category_id"], name: "index_user_categories_on_user_id_and_category_id", unique: true
    t.index ["user_id"], name: "index_user_categories_on_user_id"
  end

  create_table "user_playlist_videos", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "user_playlist_id", null: false
    t.bigint "video_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_playlist_id"], name: "index_user_playlist_videos_on_user_playlist_id"
    t.index ["video_id"], name: "index_user_playlist_videos_on_video_id"
  end

  create_table "user_playlists", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "playlist_id", null: false
    t.string "title"
    t.text "description"
    t.boolean "is_public", default: false, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["playlist_id"], name: "index_user_playlists_on_playlist_id", unique: true
    t.index ["user_id"], name: "index_user_playlists_on_user_id"
  end

  create_table "users", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "name", null: false
    t.string "email", null: false
    t.string "crypted_password"
    t.string "salt"
    t.integer "age"
    t.integer "gender", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_token_expires_at"
    t.datetime "reset_password_email_sent_at"
    t.integer "access_count_to_reset_password_page", default: 0
    t.string "remember_me_token"
    t.datetime "remember_me_token_expires_at"
    t.text "profile"
    t.string "avatar"
    t.boolean "age_is_public", default: false
    t.boolean "gender_is_public", default: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["remember_me_token"], name: "index_users_on_remember_me_token"
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token"
  end

  create_table "video_comments", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.text "body", null: false
    t.bigint "user_id", null: false
    t.bigint "video_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_video_comments_on_user_id"
    t.index ["video_id"], name: "index_video_comments_on_video_id"
  end

  create_table "videos", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "video_id", null: false
    t.string "title", null: false
    t.text "description"
    t.bigint "channel_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "category_id", null: false
    t.index ["category_id"], name: "index_videos_on_category_id"
    t.index ["channel_id"], name: "index_videos_on_channel_id"
    t.index ["video_id"], name: "index_videos_on_video_id", unique: true
  end

  add_foreign_key "best_channels", "channels"
  add_foreign_key "best_channels", "users"
  add_foreign_key "best_channels_favorites", "best_channels"
  add_foreign_key "best_channels_favorites", "users"
  add_foreign_key "best_videos", "users"
  add_foreign_key "best_videos", "videos"
  add_foreign_key "best_videos_favorites", "best_videos"
  add_foreign_key "best_videos_favorites", "users"
  add_foreign_key "channel_comments", "channels"
  add_foreign_key "channel_comments", "users"
  add_foreign_key "channel_playlist_videos", "channel_playlists"
  add_foreign_key "channel_playlist_videos", "videos"
  add_foreign_key "channel_playlists", "channels"
  add_foreign_key "content_comments", "contents"
  add_foreign_key "content_comments", "users"
  add_foreign_key "content_favorites", "contents"
  add_foreign_key "content_favorites", "users"
  add_foreign_key "contents", "users"
  add_foreign_key "contents", "videos"
  add_foreign_key "popular_videos", "users"
  add_foreign_key "popular_videos", "videos"
  add_foreign_key "subscription_channels", "channels"
  add_foreign_key "subscription_channels", "users"
  add_foreign_key "user_categories", "categories"
  add_foreign_key "user_categories", "users"
  add_foreign_key "user_playlist_videos", "user_playlists"
  add_foreign_key "user_playlist_videos", "videos"
  add_foreign_key "user_playlists", "users"
  add_foreign_key "video_comments", "users"
  add_foreign_key "video_comments", "videos"
  add_foreign_key "videos", "categories"
  add_foreign_key "videos", "channels"
end
