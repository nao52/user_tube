FactoryBot.define do
  factory :playlist do
    playlist_id { "test_id" }
    title { "test_title" }
    description { "これはテスト用のプレイリストです" }
    is_public { false }
    association :user
  end
end
