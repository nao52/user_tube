class PopularVideosController < ApplicationController
  before_action :require_login
  before_action :set_popular_videos

  def edit; end

  def update
    @popular_videos.each_with_index do |popular_video, index|
      ActiveRecord::Base.transaction do
        is_public = params["is_public#{index + 1}"] || false
        popular_video.update!(is_public:)
      end
    rescue ActiveRecord::Rollback
      flash.now[:danger] = t('.danger')
      return render :edit, status: :unprocessable_entity
    end
    redirect_to videos_user_path(current_user), success: t('.success')
  end

  private

  def set_popular_videos
    @popular_videos = current_user.popular_videos
  end
end
