FactoryBot.define do
  factory :content do
    video_url { "lehpLI6W30M" }
    rating { 3 }
    feedback { "面白い動画でした" }
    association :user
    association :video
  end
end
