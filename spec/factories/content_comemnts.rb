FactoryBot.define do
  factory :content_comment do
    sequence(:body) { |n| "これはテスト用のコメント(#{n})です" }
    association :user
    association :content
  end
end
