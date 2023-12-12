class SubscriptionChannelsController < ApplicationController
  before_action :require_login
  before_action :set_subscription_channels

  def edit; end

  def update
    @subscription_channels.each_with_index do |subscription_channel, index|
      ActiveRecord::Base.transaction do
        is_public = params["is_public#{index + 1}"] || false
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
