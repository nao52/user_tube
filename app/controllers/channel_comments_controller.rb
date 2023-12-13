class ChannelCommentsController < ApplicationController
  before_action :require_login
  before_action :set_channel, only: %i[new create]

  def new
    @channel_comment = current_user.channel_comments.build
  end

  def create
    @channel_comment = current_user.channel_comments.build(channel_comment_params)

    if @channel_comment.save
      redirect_to channel_path(@channel), success: t('.success')
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @channel_comment = ChannelComment.find(params[:id])
  end

  def update
    raise
  end

  def destroy
  end

  private

  def channel_comment_params
    params.require(:channel_comment).permit(:body, :channel_id)
  end

  def set_channel
    @channel = Channel.find(params[:channel_id])
  end
end
