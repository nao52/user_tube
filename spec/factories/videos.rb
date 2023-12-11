FactoryBot.define do
  factory :video do
    sequence(:video_id) { |n| "test-#{n}" }
    sequence(:title) { |n| "test-#{n}" }
    description { "これはテスト用のデータです" }
    association :channel 
  end
end
