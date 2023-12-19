class ContentFavoritesController < ApplicationController
  before_action :require_login, only: %i[create destroy]

  def create
    @content = Content.find(params[:content_id])
    current_user.like_content(@content)
    respond_to do |format|
      format.html { redirect_to contents_url, success: t('.success') }
      format.turbo_stream { flash.now[:success] = t('.success') }
    end
  end

  def destroy
    @content = Content.find(params[:id])
    current_user.dislike_content(@content)
    respond_to do |format|
      format.html { redirect_to contents_url, success: t('.success'), status: :see_other }
      format.turbo_stream { flash.now[:success] = t('.success') }
    end
  end
end
