class PlaylistVideo < ApplicationRecord
  belongs_to :playlist
  belongs_to :video

  class << self
    def update_playlist(playlist, videos)
      playlist.videos.delete_all unless playlist.videos.size == videos.size
      videos.each do |video|
        find_or_create_by(playlist:, video:)
      end
    end
  end
end
