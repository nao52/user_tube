class ChannelPlaylist < ApplicationRecord
  belongs_to :channel

  validates :playlist_id, presence: true, uniqueness: true
end
