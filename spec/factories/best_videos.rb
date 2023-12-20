FactoryBot.define do
  factory :best_video do
    association :user
    association :video
  end
end
