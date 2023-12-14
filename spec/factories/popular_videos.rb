FactoryBot.define do
  factory :popular_video do
    is_public { true }
    association :user
    association :video
  end
end
