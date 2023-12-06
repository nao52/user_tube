class GoogleLoginApiController < ApplicationController
  before_action :require_login

  def callback
    auth = request.env['omniauth.auth']
    access_token = auth.credentials.token
    subscription_channels = Channel.subscription_channels(access_token)
    current_user.add_subscriptions(subscription_channels)
    # pupular_videos = Video.popular_videos(access_token)
    # current_user.add_popular_videos(pupular_videos)
    redirect_back_or_to user_url(current_user), success: '登録チャンネル/高評価動画を同期しました'
  end
end
