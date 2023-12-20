FactoryBot.define do
  factory :best_channels_favorite do
    association :user
    association :best_channel
  end
end
