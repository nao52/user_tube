class ChannelsController < ApplicationController
  skip_before_action :require_login

  def index
    @search_channels_form = SearchChannelsForm.new(search_params)
    @channels = @search_channels_form.search.user_count_order.page(params[:page])
  end

  def show
    @link = params[:link] ||= 'user'
    @channel = Channel.find(params[:id])
    @channel_users = @channel.users_with_public.page(params[:page]) if @link == 'user'
    @channel_videos = @channel.videos.page(params[:page]).per(8) if @link == 'favorite_video'
    @channel_comments = @channel.channel_comments.includes(:user).page(params[:page]) if @link == 'comment'
  end

  

  private

  def search_params
    params[:q]&.permit(:name, :description, :category_title, :users_generation, :following_user_ids, :follow_users)
  end
end
