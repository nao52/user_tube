class RecentContentsController < ApplicationController
  skip_before_action :require_login

  def show
    @link = params[:link] ||= 'video'
    @recent_videos = Video.recent_and_with_users.order(created_at: :desc).page(params[:page]).per(8)
    @recent_channels = Channel.recent_and_with_users.order(created_at: :desc).page(params[:page])
  end
end
