FactoryBot.define do
  factory :video_comment do
    sequence(:body) { |n| "これはテスト用のコメント(#{n})です" }
    association :user
    association :video
  end
end
