class UserPlaylistsController < ApplicationController
  before_action :set_playlists

  def edit
    redirect_to playlists_user_url(current_user), warning: 'プレイリストを同期してください' if @playlists.empty?
  end

  def update
    @playlists.each do |playlist|
      ActiveRecord::Base.transaction do
        is_public = params["is_public#{playlist.id}"] || false
        playlist.update!(is_public:)
      end
    rescue ActiveRecord::Rollback
      flash.now[:danger] = t('.danger')
      return render :edit, status: :unprocessable_entity
    end
    redirect_to playlists_user_path(current_user), success: t('.success')
  end

  private

  def set_playlists
    @playlists = current_user.user_playlists
  end
end
