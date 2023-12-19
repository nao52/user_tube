FactoryBot.define do
  factory :content_favorite do
    association :user
    association :content
  end
end
