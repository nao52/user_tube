class ChannelCommentsController < ApplicationController
  before_action :set_channel, only: %i[new create]
  before_action :set_channel_comment, only: %i[edit update destroy]

  def new
    @channel_comment = current_user.channel_comments.build
  end

  def create
    @channel_comment = current_user.channel_comments.build(channel_comment_params)

    if @channel_comment.save
      redirect_to @channel, success: t('.success')
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit; end

  def update
    if @channel_comment.update(channel_comment_params)
      redirect_to @channel_comment.channel, success: t('.success')
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @channel = @channel_comment.channel
    @channel_comments = @channel.channel_comments.includes(:user).page(params[:page])
    @channel_comment.destroy!
    respond_to do |format|
      format.html { redirect_to @channel, success: t('.success'), status: :see_other }
      format.turbo_stream { flash.now[:success] = t('.success') }
    end
  end

  private

  def channel_comment_params
    params.require(:channel_comment).permit(:body, :channel_id)
  end

  def set_channel
    @channel = Channel.find(params[:channel_id])
  end

  def set_channel_comment
    @channel_comment = current_user.channel_comments.find(params[:id])
  end
end
