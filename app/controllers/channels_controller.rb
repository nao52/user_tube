class ChannelsController < ApplicationController
  def index
    @channels = Channel.all.page(params[:page])
  end
end
