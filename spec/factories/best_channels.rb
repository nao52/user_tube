FactoryBot.define do
  factory :best_channel do
    association :user
    association :channel
  end
end
