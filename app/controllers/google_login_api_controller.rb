class GoogleLoginApiController < ApplicationController
  before_action :require_login

  def callback
    auth = request.env['omniauth.auth']
    access_token = auth.credentials.token

    ActiveRecord::Base.transaction do
      channel_list = Channel.create_subscription_channel_list(access_token)
      current_user.add_or_delete_channels(channel_list)
      video_list = Video.create_popular_video_list(access_token)
      current_user.add_or_delete_videos(video_list)
    end
    flash[:google_login] = true
    redirect_to edit_subscription_channels_path, success: '登録チャンネル/高評価動画を同期しました。登録チャンネルの公開設定を行ってください。'
  end
end
