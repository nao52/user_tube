class Video < ApplicationRecord
  GOOGLE_API_SERVICE = Google::Apis::YoutubeV3::YouTubeService.new

  belongs_to :channel
  belongs_to :category

  has_many :popular_videos, dependent: :destroy
  has_many :users, through: :popular_videos, source: :user
  has_many :video_comments, dependent: :destroy
  has_many :user_playlist_videos, dependent: :destroy

  validates :video_id, presence: true, uniqueness: true
  validates :title, presence: true

  scope :with_users, -> { joins(:popular_videos).where(popular_videos: { video_id: ids }) }
  scope :with_following_users, ->(following_user_ids) { joins(:popular_videos).where(popular_videos: { user_id: following_user_ids }) }
  scope :recent_and_with_users, -> { where('videos.created_at >= ?', 3.days.ago.beginning_of_day).joins(:users).group('videos.id').having('COUNT(users.id) > 0') }
  scope :by_category, ->(category_id) { where(category_id:) }
  scope :by_users_generation, ->(users_generation) { joins(:users).where('age BETWEEN ? AND ?', users_generation, users_generation + 9) }
  scope :channel_name_contain, ->(word) { joins(:channel).where('LOWER(channels.name) LIKE ?', "%#{word}%") }
  scope :description_contain, ->(word) { where('LOWER(description) LIKE ?', "%#{word}%") }

  scope :user_count_order, -> { joins(:users).group('videos.id').order('COUNT(users.id) DESC, created_at DESC') }

  def users_with_public
    popular_videos_user_ids = popular_videos.where(is_public: true).map(&:user_id)
    users.where(id: popular_videos_user_ids)
  end

  class << self
    def create_popular_video_list(access_token)
      video_list = []
      GOOGLE_API_SERVICE.authorization = Signet::OAuth2::Client.new(access_token:)
      videos = GOOGLE_API_SERVICE.list_videos(:snippet, my_rating: 'like', max_results: 50)
      videos.items.each do |video|
        video_list << find_or_create_video_by_video(video)
      end
      video_list
    end

    def find_or_create_videos_by_playlist_id(playlist_id)
      videos = []
      GOOGLE_API_SERVICE.key = Settings.google_api_key
      playlist_items = GOOGLE_API_SERVICE.list_playlist_items(:snippet, playlist_id:)
      playlist_items.items.each do |playlist_item|
        video_id = playlist_item.snippet.resource_id.video_id
        video = find_or_create_video_by_video_id(video_id)
        videos << video if video
      end
      videos
    end

    def find_or_create_video_by_video_id(video_id)
      GOOGLE_API_SERVICE.key = Settings.google_api_key
      video = GOOGLE_API_SERVICE.list_videos(:snippet, id: video_id).items.first

      return nil unless video.present?

      find_or_create_video_by_video(video)
    end

    def find_or_create_video_by_video(video)
      video_params = video_params_by_video(video)
      video = find_or_initialize_by(video_id: video_params[:video_id])
      video.update(video_params)
      video
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
