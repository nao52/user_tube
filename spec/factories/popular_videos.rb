FactoryBot.define do
  factory :popular_video do
    association :user
    association :video
  end
end
