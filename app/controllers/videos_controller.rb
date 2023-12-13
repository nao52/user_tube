class VideosController < ApplicationController
  def index
    @videos = Video.all.page(params[:page]).per(8)
  end
end
