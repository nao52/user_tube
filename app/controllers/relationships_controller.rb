class RelationshipsController < ApplicationController
  def create
    @followed_user = User.find(params[:followed_id])
    current_user.follow(@followed_user)
    respond_to(&:turbo_stream)
  end

  def destroy
    @followed_user = User.find(params[:id])
    current_user.unfollow(@followed_user)
    respond_to(&:turbo_stream)
  end
end
