class BestVideo < ApplicationRecord
  belongs_to :user
  belongs_to :video

  validates :rank, presence: true, numericality: { only_integer: true, in: 1..3 }
  validates :user_id, uniqueness: { scope: :video_id }
  validates :user_id, uniqueness: { scope: :rank }
end
