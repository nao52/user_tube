class Video < ApplicationRecord
  belongs_to :channel

  validates :video_id, presence: true, uniqueness: true
  validates :title, presence: true
end
