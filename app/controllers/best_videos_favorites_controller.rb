class BestVideosFavoritesController < ApplicationController
  before_action :require_login, only: %i[create destroy]

  def create
    @best_video = BestVideo.find(params[:best_video_id])
    current_user.like_best_video(@best_video)
    respond_to do |format|
      format.html { redirect_to videos_user_path(@best_video.user), success: t('.success') }
      # format.turbo_stream { flash.now[:success] = t('.success') }
    end
  end

  def destroy
    @best_video = BestVideo.find(params[:id])
    current_user.dislike_best_video(@best_video)
    respond_to do |format|
      format.html { redirect_to videos_user_path(@best_video.user), success: t('.success'), status: :see_other }
      # format.turbo_stream { flash.now[:success] = t('.success') }
    end
  end
end
