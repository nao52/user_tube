class ChannelPlaylistVideo < ApplicationRecord
  belongs_to :channel_playlist
  belongs_to :video

  validates :channel_playlist_id, uniqueness: { scope: :video_id }

  class << self
    def update_playlist(playlist, videos)
      playlist.videos.delete_all unless playlist.videos.size == videos.size
      videos.each do |video|
        create(channel_playlist: playlist, video:)
      end
    end
  end
end
