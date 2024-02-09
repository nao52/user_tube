class InstallYoutubeDataJob < ApplicationJob
  queue_as :default

  def perform(access_token, user_id)
    Rails.logger.info('InstallYoutubeDataJobを開始')

    current_user = User.find(user_id)

    ActiveRecord::Base.transaction do
      channel_list = Channel.create_subscription_channel_list(access_token)
      current_user.add_or_delete_channels(channel_list)
      video_list = Video.create_popular_video_list(access_token)
      current_user.add_or_delete_videos(video_list)
      current_user.create_playlist(access_token)
    end

    Rails.logger.info('InstallYoutubeDataJobを完了')
  end
end
