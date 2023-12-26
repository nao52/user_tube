class Video < ApplicationRecord
  GOOGLE_API_SERVICE = Google::Apis::YoutubeV3::YouTubeService.new

  belongs_to :channel
  belongs_to :category

  has_many :popular_videos, dependent: :destroy
  has_many :users, through: :popular_videos, source: :user
  has_many :video_comments, dependent: :destroy

  validates :video_id, presence: true, uniqueness: true
  validates :title, presence: true

  scope :with_users, -> { joins(:popular_videos).merge(where(popular_videos: { video_id: ids })) }
  scope :recent_and_with_users, -> { where('videos.created_at >= ?', 3.days.ago.beginning_of_day).joins(:users).group('videos.id').having('COUNT(users.id) > 0') }
  scope :by_category, ->(category_id) { where(category_id:) }
  scope :description_contain, ->(word) { where('description LIKE ?', "%#{word}%") }

  def users_with_public
    popular_videos_user_ids = popular_videos.where(is_public: true).map(&:user_id)
    users.where(id: popular_videos_user_ids)
  end

  class << self
    def create_popular_video_list(access_token)
      video_list = []
      GOOGLE_API_SERVICE.authorization = Signet::OAuth2::Client.new(access_token:)
      videos = GOOGLE_API_SERVICE.list_videos(:snippet, my_rating: 'like', max_results: 1000)
      videos.items.each do |video|
        video_list << find_or_create_video_by_video(video)
      end
      video_list
    end

    def find_or_create_video_by_video(video)
      video_params = video_params_by_video(video)
      find_or_create_by(video_id: video_params[:video_id]) do |new_video|
        new_video.update(video_params)
      end
    end

    private

    def video_params_by_video(video)
      channel = Channel.find_or_create_channel_by_channel_id(video.snippet.channel_id)
      category_id = video.snippet.category_id || 99
      {
        video_id: video.id,
        title: video.snippet.title,
        description: video.snippet.description,
        channel_id: channel.id,
        category_id: Category.find_by(title: category_id).id
      }
    end
  end
end
