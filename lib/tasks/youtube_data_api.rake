namespace :youtube_data_api do
  desc 'チャンネルのplaylistを取得する'
  task install_channel_playlists: :environment do
    subscription_channels = Channel.with_users_and_playlist_count_order
    subscription_channels.each(&:create_playlist)
  end
end
