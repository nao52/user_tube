class BestChannelsFavorite < ApplicationRecord
  belongs_to :user
  belongs_to :best_channel

  validates :user_id, uniqueness: { scope: :best_channel_id }
end
