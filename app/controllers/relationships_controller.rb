class RelationshipsController < ApplicationController
  before_action :require_login

  def create
    @followed_user = User.find(params[:followed_id])
    current_user.follow(@followed_user)
    respond_to do |format|
      # format.html { redirect_to users_url }
      format.turbo_stream
    end
  end

  def destroy
    @followed_user = User.find(params[:id])
    current_user.unfollow(@followed_user)
    respond_to do |format|
      # format.html { redirect_to users_url, status: :see_other }
      format.turbo_stream
    end
  end
end
