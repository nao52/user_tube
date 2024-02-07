class ChannelPlaylistVideo < ApplicationRecord
  belongs_to :channel_playlist
  belongs_to :video
end
