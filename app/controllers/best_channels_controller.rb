class BestChannelsController < ApplicationController
  before_action :require_login

  def edit
    @user = current_user
    @best_channels = @user.favorite_channels.order(rank: :asc)
  end

  def update
    raise
  end
end
