FactoryBot.define do
  factory :playlist_video do
    association :playlist
    association :video
  end
end
