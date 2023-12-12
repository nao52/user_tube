FactoryBot.define do
  factory :channel_comment do
    sequence(:body) { |n| "これはテスト用のコメント(#{n})です" }
    association :user
    association :channel
  end
end
