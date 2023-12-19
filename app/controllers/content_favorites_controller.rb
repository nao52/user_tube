class ContentFavoritesController < ApplicationController
  before_action :require_login, only: %i[edit update]

  def create
    @content = Content.find(params[:content_id])
    current_user.like_content(@content)
    redirect_to contents_url, success: t('.success')
  end

  def destroy
    @content = Content.find(params[:id])
    current_user.dislike_content(@content)
    redirect_to contents_url, success: t('.success')
  end
end
