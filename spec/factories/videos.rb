FactoryBot.define do
  factory :video do
    video_id { "_2G-SrAXWeg" }
    sequence(:title) { |n| "test-#{n}" }
    description { "これはテスト用のデータです" }
    association :channel 
  end
end
