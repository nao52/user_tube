FactoryBot.define do
  factory :video do
    sequence(:video_id) { |n| "test-video_id(#{n})" }
    sequence(:title) { |n| "test-title(#{n})" }
    description { "これはテスト用のデータです" }
    association :channel
    category { Category.first || association(:category) }
  end
end
