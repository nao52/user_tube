class BestVideosController < ApplicationController
  before_action :require_login
  before_action :set_user

  def edit
    @best_videos = @user.favorite_videos.order(rank: :asc)
  end

  def update
    videos = Video.find([params[:video][:best1], params[:video][:best2], params[:video][:best3]])
    if @user.update_favorite_videos(videos)
      redirect_to @user, success: t('.success')
    else
      @best_videos = @user.favorite_videos.order(rank: :asc)
      flash.now[:danger] = t('.danger')
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def set_user
    @user = current_user
  end
end
