class Channel < ApplicationRecord
  GOOGLE_API_SERVICE = Google::Apis::YoutubeV3::YouTubeService.new

  has_many :subscription_channels, dependent: :destroy
  has_many :users, through: :subscription_channels, source: :user
  has_many :videos, dependent: :destroy
  has_many :channel_comments, dependent: :destroy
  has_many :channel_playlists, dependent: :destroy

  validates :channel_id, presence: true, uniqueness: true
  validates :name, presence: true
  validates :subscriber_count, presence: true, numericality: { only_integer: true }

  scope :with_users, -> { joins(:subscription_channels).where(subscription_channels: { channel_id: ids }) }
  scope :with_following_users, ->(following_user_ids) { joins(:subscription_channels).where(subscription_channels: { user_id: following_user_ids }) }
  scope :recent_and_with_users, -> { where('channels.created_at >= ?', 3.days.ago.beginning_of_day).joins(:users).group('channels.id').having('COUNT(users.id) > 0') }
  scope :name_contain, ->(name) { where('LOWER(name) LIKE ?', "%#{name}%") }
  scope :description_contain, ->(word) { where('LOWER(description) LIKE ?', "%#{word}%") }
  scope :by_category, ->(category_id) { joins(:videos).where(videos: { category_id: }) }
  scope :by_users_generation, ->(users_generation) { joins(:users).where('age BETWEEN ? AND ?', users_generation, users_generation + 9) }

  scope :user_count_order, -> { joins(:users).select('channels.*, COUNT(users.id) as user_count').group('channels.id').order('user_count DESC, channels.created_at DESC') }


  def users_with_public
    subscription_channels_user_ids = subscription_channels.where(is_public: true).map(&:user_id)
    users.where(id: subscription_channels_user_ids)
  end

  class << self
    def create_subscription_channel_list(access_token)
      channel_list = []
      GOOGLE_API_SERVICE.authorization = Signet::OAuth2::Client.new(access_token:)
      subscriptions = GOOGLE_API_SERVICE.list_subscriptions(:snippet, mine: true, max_results: 50)
      subscriptions.items.each do |item|
        channel_id = item.snippet.resource_id.channel_id
        channel_list << find_or_create_channel_by_channel_id(channel_id)
      end
      channel_list
    end

    def find_or_create_channel_by_channel_id(channel_id)
      channel_params = channel_params_by_channel_id(channel_id)
      channel = find_or_initialize_by(channel_id: channel_params[:channel_id])
      channel.update(channel_params)
      channel
    end

    private

    def channel_params_by_channel_id(channel_id)
      GOOGLE_API_SERVICE.key = Settings.google_api_key
      channel_info = GOOGLE_API_SERVICE.list_channels('snippet,statistics', id: channel_id).items[0]
      {
        channel_id:,
        thumbnail_url: channel_info.snippet.thumbnails.medium.url,
        name: channel_info.snippet.title,
        subscriber_count: channel_info.statistics.subscriber_count,
        description: channel_info.snippet.description
      }
    end
  end

  def create_playlist
    GOOGLE_API_SERVICE.key = Settings.google_api_key
    playlists = GOOGLE_API_SERVICE.list_playlists(:snippet, channel_id:, max_results: 50)
    return if playlists.items.empty?

    playlists.items.each do |playlist_item|
      playlist_params = playlist_params_by_playlist_item(playlist_item)
      playlist_id = playlist_params[:playlist_id]
      playlist = channel_playlists.find_or_initialize_by(playlist_id:)
      playlist.update!(playlist_params)

      videos = Video.find_or_create_videos_by_playlist_id(playlist_id)
      ChannelPlaylistVideo.update_playlist(playlist, videos)
    end
  end

  private

  def playlist_params_by_playlist_item(playlist_item)
    {
      playlist_id: playlist_item.id,
      title: playlist_item.snippet.title,
      description: playlist_item.snippet.description
    }
  end
end
