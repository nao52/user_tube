class Content < ApplicationRecord
  belongs_to :user
  belongs_to :video
  has_many :content_comments, dependent: :destroy
  has_many :content_favorites, dependent: :destroy

  validates :video_url, presence: true
  validates :rating, presence: true, numericality: { only_integer: true, in: 1..5 }
  validates :feedback, presence: true, length: { maximum: 400 }

  default_scope -> { order(created_at: :desc) }
end
