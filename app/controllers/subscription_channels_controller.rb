class SubscriptionChannelsController < ApplicationController
  before_action :require_login
  before_action :set_subscription_channels

  def edit; end

  def update
    @subscription_channels.each do |subscription_channel|
      ActiveRecord::Base.transaction do
        is_public = params["is_public#{subscription_channel.id}"] || false
        subscription_channel.update!(is_public:)
      end
    rescue ActiveRecord::Rollback
      flash.now[:danger] = t('.danger')
      return render :edit, status: :unprocessable_entity
    end

    if params[:setting_public]
      redirect_to edit_popular_videos_path, success: 'チャンネルの公開設定を行いました。続けて、高評価動画の公開設定を行ってください。'
    else
      redirect_to channels_user_path(current_user), success: t('.success')
    end
  end

  private

  def set_subscription_channels
    @subscription_channels = current_user.subscription_channels
  end
end
