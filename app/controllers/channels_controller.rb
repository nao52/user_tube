class ChannelsController < ApplicationController
  skip_before_action :require_login

  def index
    @search_channels_form = SearchChannelsForm.new(search_params)
    @channels = @search_channels_form.search.order(created_at: :desc).page(params[:page])
  end

  def show
    @link = params[:link] ||= 'comment'
    @channel = Channel.find(params[:id])
    @channel_comments = @channel.channel_comments.includes(:user).page(params[:page]) if @link == 'comment'
    @channel_videos = @channel.videos.page(params[:page]) if @link == 'video'
    @channel_users = @channel.users_with_public.page(params[:page]) if @link == 'user'
  end

  private

  def search_params
    params[:q]&.permit(:name, :description, :category_title, :users_generation)
  end
end
