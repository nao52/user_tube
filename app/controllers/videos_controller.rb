class VideosController < ApplicationController
  def index
    @videos = Video.with_users.order(created_at: :desc).page(params[:page]).per(8)
  end

  def show
    @link = params[:link] ||= 'comment'
    @video = Video.find(params[:id])
    @video_comments = @video.video_comments.includes(:user).page(params[:page]) if @link == 'comment'
    @video_users = @video.users_with_public.page(params[:page]) if @link == 'user'
  end
end
