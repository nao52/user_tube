class VideosController < ApplicationController
  def index
    @search_videos_form = SearchVideosForm.new(search_params)
    @videos = @search_videos_form.search.order(created_at: :desc).page(params[:page]).per(8)
  end

  def show
    @link = params[:link] ||= 'comment'
    @video = Video.find(params[:id])
    @video_comments = @video.video_comments.includes(:user).page(params[:page]) if @link == 'comment'
    @video_users = @video.users_with_public.page(params[:page]) if @link == 'user'
  end

  private

  def search_params
    params[:q]&.permit(:description, :category_title)
  end
end
