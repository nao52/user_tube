class ContentsController < ApplicationController
  def index
    @contents = Content.all.page(params[:page]).per(8)
  end

  def show
    @content = Content.find(params[:id])
    @content_comments = @content.content_comments.includes(:user).page(params[:page])
  end
end
