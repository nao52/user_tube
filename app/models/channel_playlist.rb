class ChannelPlaylist < ApplicationRecord
  belongs_to :channel

  has_many :channel_playlist_videos, dependent: :destroy
  has_many :videos, through: :channel_playlist_videos, source: :video

  validates :playlist_id, presence: true, uniqueness: true
end
