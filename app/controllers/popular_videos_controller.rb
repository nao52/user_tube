class PopularVideosController < ApplicationController
  before_action :require_login
  before_action :set_popular_videos

  def edit
    redirect_to videos_user_url(current_user), warning: '高評価動画を同期してください' if @popular_videos.empty?
  end

  def update
    @popular_videos.each do |popular_video|
      ActiveRecord::Base.transaction do
        is_public = params["is_public#{popular_video.id}"] || false
        popular_video.update!(is_public:)
      end
    rescue ActiveRecord::Rollback
      flash.now[:danger] = t('.danger')
      return render :edit, status: :unprocessable_entity
    end
    if params[:google_login]
      redirect_to edit_playlists_path, success: '高評価動画の公開設定を行いました。続けて、プレイリストの公開設定を行ってください。'
    else
      redirect_to videos_user_path(current_user), success: t('.success')
    end
  end

  private

  def set_popular_videos
    @popular_videos = current_user.popular_videos
  end
end
