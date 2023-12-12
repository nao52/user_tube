class ChannelComment < ApplicationRecord
  belongs_to :user
  belongs_to :channel

  validates :body, presence: true, length: { maximum: 400 }
end
