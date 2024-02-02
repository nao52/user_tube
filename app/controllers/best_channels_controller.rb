class BestChannelsController < ApplicationController
  before_action :set_user

  def edit
    @best_channels = @user.favorite_channels.order(rank: :asc)
  end

  def update
    channels = Channel.find([params[:channel][:best1], params[:channel][:best2], params[:channel][:best3]])
    if @user.update_favorite_channels(channels)
      redirect_to @user, success: t('.success')
    else
      @best_channels = @user.favorite_channels.order(rank: :asc)
      flash.now[:danger] = t('.danger')
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def set_user
    @user = current_user
  end
end
