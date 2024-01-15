class Playlist < ApplicationRecord
  belongs_to :user

  has_many :playlist_videos, dependent: :destroy

  validates :playlist_id, presence: true, uniqueness: true
end
