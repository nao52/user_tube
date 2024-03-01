FactoryBot.define do
  factory :best_channel do
    association :user
    association :channel
    rank { 1 }

    factory :best_channel_rank_1 do
      rank { 1 }
    end

    factory :best_channel_rank_2 do
      rank { 2 }
    end

    factory :best_channel_rank_3 do
      rank { 3 }
    end
  end
end
