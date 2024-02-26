class Content < ApplicationRecord
  belongs_to :user
  belongs_to :video
  has_many :content_comments, dependent: :destroy
  has_many :content_favorites, dependent: :destroy

  validates :video_url, presence: true
  validates :rating, presence: true, numericality: { only_integer: true, in: 1..5 }
  validates :feedback, presence: true, length: { maximum: 400 }
  validate :video_url_is_youtube_url

  default_scope -> { order(created_at: :desc) }

  private

  def video_url_is_youtube_url
    return unless video_url.present?

    service = Google::Apis::YoutubeV3::YouTubeService.new
    service.key = Settings.google_api_key

    video = service.list_videos(:snippet, id: video_url).items.first
    errors.add(:video_url, 'は不正なURLです。') if video.blank?
  end
end
