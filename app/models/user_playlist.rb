class UserPlaylist < ApplicationRecord
  belongs_to :user

  has_many :playlist_videos, dependent: :destroy
  has_many :videos, through: :playlist_videos, source: :video

  validates :playlist_id, presence: true, uniqueness: true
end
