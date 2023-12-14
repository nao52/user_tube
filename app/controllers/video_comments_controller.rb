class VideoCommentsController < ApplicationController
  before_action :require_login
  before_action :set_video, only: %i[new create]
  before_action :set_video_comment, only: %i[edit update destroy]

  def new
    @video_comment = current_user.video_comments.build
  end

  def create
    raise
  end

  def edit; end

  def update
    raise
  end

  def destroy
    raise
  end

  private

  def video_comment_params
    params.require(:video_comment).permit(:body, :video_id)
  end

  def set_video
    @video = Video.find(params[:video_id])
  end

  def set_video_comment
    @video_comment = current_user.video_comments.find(params[:id])
  end
end
