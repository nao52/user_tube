class ContentsForm
  include ActiveModel::Model
  include ActiveModel::Attributes

  attribute :video_url, default: ''
  attribute :rating, default: nil
  attribute :feedback, default: ''

  validates :video_url, presence: true
  validates :rating, presence: true, numericality: { only_integer: true, in: 1..5 }
  validates :feedback, presence: true, length: { maximum: 400 }
  validate :video_url_is_youtube_url

  def initialize(user, attributes = {}, content = nil)
    @service = Google::Apis::YoutubeV3::YouTubeService.new
    @service.key = Settings.google_api_key
    @user = user
    @content = content
    @video = nil
    attributes['video_url'] = create_id_from_youtube_url(attributes['video_url']) if attributes['video_url'].present?
    super(default_attributes.merge(attributes))
  end

  def save(content_params)
    return false if invalid?

    ActiveRecord::Base.transaction do
      video = Video.find_or_create_video_by_video(@video)
      content_params['video_id'] = video.id
      content_params['video_url'] = create_id_from_youtube_url(content_params['video_url'])
      @user.contents.create(content_params)
    end
  end

  def update(content_params)
    return false if invalid?

    ActiveRecord::Base.transaction do
      video = Video.find_or_create_video_by_video(@video)
      content_params['video_id'] = video.id
      content_params['video_url'] = create_id_from_youtube_url(content_params['video_url'])
      @content.update(content_params)
    end
  end

  private

  def default_attributes
    return {} if @content.nil?

    {
      'video_url' => @content.attributes['video_url'].split('/').last.split('?').first,
      'rating' => @content.attributes['rating'],
      'feedback' => @content.attributes['feedback']
    }
  end

  def video_url_is_youtube_url
    return false unless video_url.present?

    @video = @service.list_videos(:snippet, id: video_url).items.first
    return unless @video.nil?

    errors.add(:video_url, 'は不正なURLです。')
  end

  def create_id_from_youtube_url(video_url)
    video_url&.split('/')&.last&.split('?')&.first
  end
end
