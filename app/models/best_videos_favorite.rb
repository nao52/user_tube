class BestVideosFavorite < ApplicationRecord
  belongs_to :user
  belongs_to :best_video

  validates :user_id, uniqueness: { scope: :best_video_id }
end
