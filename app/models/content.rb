class Content < ApplicationRecord
  before_save :split_id_from_youtube_url
  before_save :save_video
  before_save :save_video_id

  belongs_to :user
  belongs_to :video
  has_many :content_comments, dependent: :destroy

  validates :video_url, presence: true
  validates :rating, presence: true, numericality: { only_integer: true, in: 1..5 }
  validates :feedback, presence: true, length: { maximum: 400 }
  validate :video_url_is_youtube_url

  default_scope -> { order(created_at: :desc) }

  private

  def video_url_is_youtube_url
    return false unless video_url.present?

    video_url = self.video_url.split('/').last.split('?').first
    service = Google::Apis::YoutubeV3::YouTubeService.new
    service.key = Settings.google_api_key
    video = service.list_videos(:snippet, id: video_url)
    return unless video.items[0].nil?

    errors.add(:video_url, 'は不正なURLです。')
  end

  def split_id_from_youtube_url
    self.video_url = video_url.split('/').last.split('?').first
  end

  def save_video
    Video.find_or_create_from_video_id(video_url)
  end

  def save_video_id
    self.video_id = Video.find_by(video_id: video_url).id
  end
end
