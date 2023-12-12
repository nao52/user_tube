class ChannelsController < ApplicationController
  def index
    @channels = Channel.all.page(params[:page])
  end

  def show
    @channel = Channel.find(params[:id])
    @channel_comments = @channel.channel_comments.includes(:user).page(params[:page])
  end
end
