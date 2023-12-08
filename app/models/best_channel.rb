class BestChannel < ApplicationRecord
  belongs_to :user
  belongs_to :channel

  validates :rank, presence: true, numericality: { only_integer: true, in: 1..3 }
  validates :user_id, uniqueness: { scope: :channel_id }
  validates :user_id, uniqueness: { scope: :rank }
end
