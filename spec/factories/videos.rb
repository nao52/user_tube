FactoryBot.define do
  factory :video do
    video_id { "_2G-SrAXWeg" }
    sequence(:title) { |n| "test-title(#{n})" }
    description { "これはテスト用のデータです" }
    association :channel
    association :category
  end
end
