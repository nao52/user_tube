FactoryBot.define do
  factory :user_playlist do
    playlist_id { "test_id" }
    title { "test_title" }
    description { "これはテスト用のプレイリストです" }
    association :user
  end
end
