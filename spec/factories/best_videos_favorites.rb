FactoryBot.define do
  factory :best_videos_favorite do
    association :user
    association :best_video
  end
end
