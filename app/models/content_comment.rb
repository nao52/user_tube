class ContentComment < ApplicationRecord
  belongs_to :user
  belongs_to :content

  validates :body, presence: true, length: { maximum: 400 }

  default_scope -> { order(created_at: :desc) }
end
