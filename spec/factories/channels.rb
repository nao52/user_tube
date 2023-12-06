FactoryBot.define do
  factory :channel do
    channel_id { "test" }
    thumbnail_url { "test" }
    name { "test" }
    subscriber_count { 100 }
    description { "これはテスト用のデータです" }
  end
end
