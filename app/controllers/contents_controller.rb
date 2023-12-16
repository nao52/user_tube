class ContentsController < ApplicationController
  def index
    @contents = Content.all.page(params[:page]).per(8)
  end

  def show
    @content = Content.find(params[:id])
  end
end
