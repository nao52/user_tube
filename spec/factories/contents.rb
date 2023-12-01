FactoryBot.define do
  factory :content do
    video_url { "test" }
    rating { 3 }
    feedback { "面白い動画でした" }
    association :user
  end
end
