class Channel < ApplicationRecord
  has_many :subscription_channels, dependent: :destroy

  validates :channel_id, presence: true, uniqueness: true
  validates :name, presence: true
  validates :subscriber_count, presence: true, numericality: { only_integer: true }
end
