class UserPlaylistVideo < ApplicationRecord
  belongs_to :user_playlist
  belongs_to :video

  validates :user_playlist_id, uniqueness: { scope: :video_id }

  class << self
    def update_playlist(playlist, videos)
      playlist.videos.delete_all unless playlist.videos.size == videos.size
      videos.each do |video|
        create(user_playlist: playlist, video:)
      end
    end
  end
end
