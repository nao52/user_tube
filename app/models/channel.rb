class Channel < ApplicationRecord
  GOOGLE_API_SERVICE = Google::Apis::YoutubeV3::YouTubeService.new

  has_many :subscription_channels, dependent: :destroy
  has_many :users, through: :subscription_channels, source: :user
  has_many :videos, dependent: :destroy
  has_many :channel_comments, dependent: :destroy

  validates :channel_id, presence: true, uniqueness: true
  validates :name, presence: true
  validates :subscriber_count, presence: true, numericality: { only_integer: true }

  scope :with_users, -> { joins(:subscription_channels).merge(where(subscription_channels: { channel_id: ids })) }
  scope :recent_and_with_users, -> { where('channels.created_at >= ?', 3.days.ago.beginning_of_day).joins(:users).group('channels.id').having('COUNT(users.id) > 0') }
  scope :name_contain, ->(name) { where('name LIKE ?', "%#{name}%") }
  scope :description_contain, ->(word) { where('description LIKE ?', "%#{word}%") }

  def users_with_public
    subscription_channels_user_ids = subscription_channels.where(is_public: true).map(&:user_id)
    users.where(id: subscription_channels_user_ids)
  end

  class << self
    def create_subscription_channel_list(access_token)
      channel_list = []
      GOOGLE_API_SERVICE.authorization = Signet::OAuth2::Client.new(access_token:)
      subscriptions = GOOGLE_API_SERVICE.list_subscriptions(:snippet, mine: true, max_results: 100)
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
end
