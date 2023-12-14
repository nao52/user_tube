class VideoCommentsController < ApplicationController
  before_action :require_login
  before_action :set_video, only: %i[new create]
  before_action :set_video_comment, only: %i[edit update destroy]

  def new
    @video_comment = current_user.video_comments.build
  end

  def create
    @video_comment = current_user.video_comments.build(video_comment_params)

    if @video_comment.save
      redirect_to @video, success: t('.success')
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit; end

  def update
    if @video_comment.update(video_comment_params)
      redirect_to @video_comment.video, success: t('.success')
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @video = @video_comment.video
    @video_comments = @video.video_comments.includes(:user).page(params[:page])
    @video_comment.destroy!
    flash[:success] = t('.success')
    respond_to do |format|
      format.html { redirect_to @video, status: :see_other }
      # format.turbo_stream
    end
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
