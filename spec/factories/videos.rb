FactoryBot.define do
  factory :video do
    sequence(:video_id) { |n| "test-#{n}" }
    title { "test" }
    description { "これはテスト用のデータです" }
    association :channel 
  end
end
