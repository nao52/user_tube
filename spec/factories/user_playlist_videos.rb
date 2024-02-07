FactoryBot.define do
  factory :user_playlist_video do
    association :user_playlist
    association :video
  end
end
