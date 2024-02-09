class GoogleLoginApiController < ApplicationController
  skip_before_action :require_login

  def callback
    auth = request.env['omniauth.auth']
    redirect_to root_url if auth.nil?

    @user = User.find_by(email: auth.info.email)
    @user = User.create!(auth_user_params(auth)) if @user.nil?

    auto_login(@user)
    redirect_to videos_url, success: 'ログインに成功しました'
  end

  private

  def auth_user_params(auth)
    password = generate_password(8)
    {
      name: auth.info.name,
      email: auth.info.email,
      password:,
      password_confirmation: password
    }
  end

  def generate_password(length)
    lowercase_letters = ('a'..'z').to_a
    uppercase_letters = ('A'..'Z').to_a
    numbers = (0..9).to_a
    all_characters = lowercase_letters + uppercase_letters + numbers
    Array.new(length) { all_characters.sample }.join
  end

  # def callback
  #   auth = request.env['omniauth.auth']
  #   access_token = auth.credentials.token

  #   ActiveRecord::Base.transaction do
  #     channel_list = Channel.create_subscription_channel_list(access_token)
  #     current_user.add_or_delete_channels(channel_list)
  #     video_list = Video.create_popular_video_list(access_token)
  #     current_user.add_or_delete_videos(video_list)
  #     current_user.create_playlist(access_token)
  #   end
  #   flash[:google_login] = true
  #   redirect_to edit_subscription_channels_path, success: '登録チャンネル/高評価動画/プレイリストを同期しました。登録チャンネルの公開設定を行ってください。'
  # end
end
