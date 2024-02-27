FactoryBot.define do
  factory :subscription_channel do
    association :user
    association :channel
  end
end
