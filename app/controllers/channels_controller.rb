class ChannelsController < ApplicationController
  skip_before_action :require_login
  before_action :set_channel, only: %i[users videos comments playlists]

  def index
    @search_channels_form = SearchChannelsForm.new(search_params)
    @channels = @search_channels_form.search.user_count_order.page(params[:page])
  end

  def users
    @channel_users = @channel.users_with_public.page(params[:page])
    render 'channels/show'
  end

  def videos
    @channel_videos = @channel.videos.page(params[:page]).per(8)
    render 'channels/show'
  end

  def comments
    @channel_comments = @channel.channel_comments.includes(:user).page(params[:page])
    render 'channels/show'
  end

  def playlists
    @channel_playlists = @channel.channel_playlists.page(params[:page]).per(8)
    render 'channels/show'
  end

  private

  def search_params
    params[:q]&.permit(:name, :description, :category_title, :users_generation, :following_user_ids, :follow_users)
  end

  def set_channel
    @channel = Channel.find(params[:id])
  end
end
