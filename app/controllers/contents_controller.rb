class ContentsController < ApplicationController
  before_action :require_login, only: %i[new create edit update destroy]

  def index
    @contents = Content.includes(:user, video: :channel).page(params[:page]).per(8)
  end

  def show
    @content = Content.find(params[:id])
    @content_comments = @content.content_comments.includes(:user).page(params[:page])
  end

  def new
    @content = current_user.contents.build
  end

  def create
    @content = current_user.contents.build(content_params)

    if @content.save
      redirect_to @content, success: t('.success')
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @content = current_user.contents.find(params[:id])
  end

  def update
    raise
  end

  def destroy
  end

  private

  def content_params
    params.require(:content).permit(:video_url, :rating, :feedback)
  end
end
