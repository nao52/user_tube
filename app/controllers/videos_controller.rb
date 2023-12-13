class VideosController < ApplicationController
  def index
    @videos = Video.all.page(params[:page])
  end
end
