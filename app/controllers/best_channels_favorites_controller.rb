class BestChannelsFavoritesController < ApplicationController
  before_action :require_login, only: %i[create destroy]

  def create
    @best_channel = BestChannel.find(params[:best_channel_id])
    current_user.like_best_channel(@best_channel)
    respond_to do |format|
      format.html { redirect_to channels_user_path(@best_channel.user), success: t('.success') }
      format.turbo_stream { flash.now[:success] = t('.success') }
    end
  end

  def destroy
    @best_channel = BestChannel.find(params[:id])
    current_user.dislike_best_channel(@best_channel)
    respond_to do |format|
      format.html { redirect_to channels_user_path(@best_channel.user), success: t('.success'), status: :see_other }
      format.turbo_stream { flash.now[:success] = t('.success') }
    end
  end
end
