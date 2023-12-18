class ContentsController < ApplicationController
  before_action :require_login, only: %i[new create edit update destroy]
  before_action :set_content, only: %i[edit update destroy]

  def index
    @contents = Content.includes(:user, video: :channel).order(created_at: :desc).page(params[:page]).per(8)
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

  def edit; end

  def update
    if @content.update(content_params)
      redirect_to @content, success: t('.success')
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @content.destroy!
    respond_to do |format|
      format.html { redirect_to contents_url, success: t('.success'), status: :see_other }
      format.turbo_stream { flash.now[:success] = t('.success') }
    end
  end

  private

  def content_params
    params.require(:content).permit(:video_url, :rating, :feedback)
  end

  def set_content
    @content = current_user.contents.find(params[:id])
  end
end
