class ContentCommentsController < ApplicationController
  before_action :require_login
  before_action :set_content, only: %i[new create]
  before_action :set_content_comment, only: %i[edit update destroy]

  def new
    @content_comment = current_user.content_comments.build
  end

  def create
    @content_comment = current_user.content_comments.build(content_comment_params)

    if @content_comment.save
      redirect_to @content, success: t('.success')
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @content_comment.update(content_comment_params)
      redirect_to @content_comment.content, success: t('.success')
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @content = @content_comment.content
    @content_comments = @content.content_comments.includes(:user).page(params[:page])
    @content_comment.destroy!
    respond_to do |format|
      format.html { redirect_to @content, success: t('.success'), status: :see_other }
      # format.turbo_stream { flash.now[:success] = t('.success') }
    end
  end

  private

  def content_comment_params
    params.require(:content_comment).permit(:body, :content_id)
  end

  def set_content
    @content = Content.find(params[:content_id])
  end

  def set_content_comment
    @content_comment = current_user.content_comments.find(params[:id])
  end
end
