FactoryBot.define do
  factory :channel do
    sequence(:channel_id) { |n| "test-#{n}" }
    name { "test" }
    subscriber_count { 100 }
    description { "これはテスト用のデータです" }
  end
end
