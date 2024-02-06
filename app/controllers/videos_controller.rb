class VideosController < ApplicationController
  skip_before_action :require_login

  def index
    @search_videos_form = SearchVideosForm.new(search_params)
    @videos = @search_videos_form.search.user_count_order.page(params[:page]).per(8)
  end

  def show
    @link = params[:link] ||= 'comment'
    @video = Video.find(params[:id])
    @video_comments = @video.video_comments.includes(:user).page(params[:page]) if @link == 'comment'
    @video_users = @video.users_with_public.page(params[:page]) if @link == 'user'
  end

  private

  def search_params
    params[:q]&.permit(:channel_name, :description, :category_title, :users_generation, :following_user_ids, :follow_users)
  end
end
