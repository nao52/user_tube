FactoryBot.define do
  factory :video do
    video_id { "test" }
    title { "test" }
    description { "これはテスト用のデータです" }
    association :channel 
  end
end
