class UserPlaylist < ApplicationRecord
  belongs_to :user

  has_many :user_playlist_videos, dependent: :destroy
  has_many :videos, through: :user_playlist_videos, source: :video

  validates :playlist_id, presence: true, uniqueness: true
  validates :title, presence: true
end
