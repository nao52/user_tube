class Video < ApplicationRecord
  belongs_to :channel
  has_many :popular_videos, dependent: :destroy
  has_many :users, through: :popular_videos, source: :user
  has_many :video_comments, dependent: :destroy

  validates :video_id, presence: true, uniqueness: true
  validates :title, presence: true

  def users_with_public
    popular_videos_user_ids = popular_videos.where(is_public: true).map(&:user_id)
    users.where(id: popular_videos_user_ids)
  end

  class << self
    def popular_videos(access_token)
      popular_videos = []
      service = Google::Apis::YoutubeV3::YouTubeService.new
      service.authorization = Signet::OAuth2::Client.new(access_token:)
      videos = service.list_videos(:snippet, my_rating: 'like', max_results: 1000)
      videos.items.each do |video|
        popular_videos << find_or_create_from_popular_videos(video)
      end
      popular_videos
    end

    private

    def find_or_create_from_popular_videos(video)
      video_params = video_params_from_popular_videos(video)
      find_or_create_by(video_id: video_params[:video_id]) do |existing_video|
        existing_video.update(video_params)
      end
    end

    def video_params_from_popular_videos(video)
      channel = Channel.find_or_create_by_channel_id(video.snippet.channel_id)
      {
        video_id: video.id,
        title: video.snippet.title,
        description: video.snippet.description,
        channel_id: channel.id
      }
    end
  end
end
