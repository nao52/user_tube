namespace :youtube_data_api do
  desc "チャンネルのplaylistを取得する"
  task install_channel_playlists: :environment do
    subscription_channels = Channel.distinct.with_users
    subscription_channels.each do |subscription_channel|
      subscription_channel.create_playlist
    end
  end
end
