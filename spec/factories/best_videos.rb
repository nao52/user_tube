FactoryBot.define do
  factory :best_video do
    association :user
    association :video
    rank { 1 }

    factory :best_video_rank_1 do
      rank { 1 }
    end

    factory :best_video_rank_2 do
      rank { 2 }
    end

    factory :best_video_rank_3 do
      rank { 3 }
    end
  end
end
