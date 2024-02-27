class SubscriptionChannel < ApplicationRecord
  belongs_to :user
  belongs_to :channel

  validates :channel_id, uniqueness: { scope: :user_id }
end
