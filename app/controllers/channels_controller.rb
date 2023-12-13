class ChannelsController < ApplicationController
  def index
    @channels = Channel.all.page(params[:page])
  end

  def show
    @link = params[:link] ||= 'comment'
    @channel = Channel.find(params[:id])
    @channel_comments = @channel.channel_comments.includes(:user).page(params[:page]) if @link == 'comment'
    @channel_videos = @channel.videos.page(params[:page]) if @link == 'video'
    @channel_users = @channel.users.page(params[:page]) if @link == 'user'
  end
end
