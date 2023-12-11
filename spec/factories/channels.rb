FactoryBot.define do
  factory :channel do
    sequence(:channel_id) { |n| "test-#{n}" }
    sequence(:name) { |n| "test-#{n}" }
    subscriber_count { 100 }
    description { "これはテスト用のデータです" }
  end
end
