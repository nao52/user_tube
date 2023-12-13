class ChannelCommentsController < ApplicationController
  before_action :require_login, only: %i[new create edit update destroy]

  def new
    @channel = Channel.find(params[:channel_id])
    @channel_comment = current_user.channel_comments.build
  end

  def create
    raise
  end

  def edit
  end

  def update
  end

  def destroy
  end
end
