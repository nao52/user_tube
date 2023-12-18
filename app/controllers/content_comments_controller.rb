class ContentCommentsController < ApplicationController
  before_action :require_login
  before_action :set_content, only: %i[new create]

  def new
    @content_comment = current_user.content_comments.build
  end

  def create
    raise
  end

  def edit
  end

  def update
    raise
  end

  def destroy
    raise
  end

  private

  def set_content
    @content = Content.find(params[:content_id])
  end
end
