FactoryBot.define do
  factory :channel_playlist do
    sequence(:playlist_id) { |n| "test_id#{n}" }
    title { "test_title" }
    description { "これはテスト用のプレイリストです" }
    association :channel
  end
end
