class SubscriptionChannelsController < ApplicationController
  before_action :set_subscription_channels

  def edit
    redirect_to channels_user_url(current_user), warning: '登録チャンネルを同期してください' if @subscription_channels.empty?
  end

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

    redirect_to channels_user_path(current_user), success: t('.success')
  end

  private

  def set_subscription_channels
    @subscription_channels = current_user.subscription_channels
  end
end
