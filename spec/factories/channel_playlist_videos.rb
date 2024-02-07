FactoryBot.define do
  factory :channel_playlist_video do
    association :channel_playlist
    association :video
  end
end
