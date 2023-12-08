class BestVideosController < ApplicationController
  before_action :require_login

  def edit
    @user = current_user
    @best_videos = @user.favorite_videos.order(rank: :asc)
  end

  def update
    raise
  end
end
