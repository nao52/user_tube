class User < ApplicationRecord
  authenticates_with_sorcery!
  mount_uploader :avatar, AvatarUploader

  before_save :downcase_email

  has_many :contents
  has_many :microposts, dependent: :destroy
  has_many :active_relationships,  class_name: 'Relationship', foreign_key: 'follower_id', dependent: :destroy
  has_many :passive_relationships, class_name: 'Relationship', foreign_key: 'followed_id', dependent: :destroy
  has_many :following, through: :active_relationships,  source: :followed
  has_many :followers, through: :passive_relationships, source: :follower
  has_many :subscription_channels, dependent: :destroy
  has_many :channels, through: :subscription_channels, source: :channel
  has_many :popular_videos, dependent: :destroy
  has_many :videos, through: :popular_videos, source: :video
  has_many :best_videos, dependent: :destroy
  has_many :favorite_videos, through: :best_videos, source: :video
  has_many :best_channels, dependent: :destroy
  has_many :favorite_channels, through: :best_channels, source: :channel
  has_many :channel_comments, dependent: :destroy
  has_many :video_comments, dependent: :destroy
  has_many :content_comments, dependent: :destroy
  has_many :content_favorites, dependent: :destroy
  has_many :like_contents, through: :content_favorites, source: :content
  has_many :best_channels_favorites, dependent: :destroy
  has_many :like_best_channels, through: :best_channels_favorites, source: :best_channel
  has_many :best_videos_favorites, dependent: :destroy
  has_many :like_best_videos, through: :best_videos_favorites, source: :best_video
  has_many :user_categories, dependent: :destroy
  has_many :categories, through: :user_categories, source: :category

  validates :password, presence: true, length: { minimum: 8 }, if: -> { new_record? || changes[:crypted_password] }
  validates :password, confirmation: true, if: -> { new_record? || changes[:crypted_password] }
  validates :password_confirmation, presence: true, if: -> { new_record? || changes[:crypted_password] }
  validates :name, presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 }, format: { with: VALID_EMAIL_REGEX }, uniqueness: true
  validates :age, allow_nil: true, numericality: { only_integer: true, in: 13..100 }
  validates :gender, presence: true
  validates :profile, length: { maximum: 400 }
  validates :reset_password_token, uniqueness: true, allow_nil: true
  validates :remember_me_token, uniqueness: true, allow_nil: true

  # 性別 { 回答なし: 0, 男性: 1, 女性: 2, その他: 9 }
  enum gender: { not_known: 0, male: 1, female: 2, not_applicabel: 9 }

  scope :by_age, ->(age) { where(age:) }
  scope :by_category, ->(category_id) { joins(:user_categories).merge(where(user_categories: { category_id: })) }
  scope :by_channel, ->(channel_id) { joins(:subscription_channels).merge(where(subscription_channels: { channel_id: })) }
  scope :name_contain, ->(name) { where('name LIKE ?', "%#{name}%") }

  def subscription_channels_with_public
    subscription_channels_channel_ids = subscription_channels.where(is_public: true).map(&:channel_id)
    channels.where(id: subscription_channels_channel_ids)
  end

  def popular_videos_with_public
    popular_videos_video_ids = popular_videos.where(is_public: true).map(&:video_id)
    videos.where(id: popular_videos_video_ids)
  end

  def follow(other_user)
    following << other_user unless self == other_user && following?(other_user)
  end

  def unfollow(other_user)
    following.delete(other_user)
  end

  def following?(other_user)
    following.include?(other_user)
  end

  def like_content(content)
    like_contents << content unless like_content?(content)
  end

  def dislike_content(content)
    like_contents.delete(content)
  end

  def like_content?(content)
    like_contents.include?(content)
  end

  def like_best_channel(best_channel)
    like_best_channels << best_channel unless like_best_channel?(best_channel)
  end

  def dislike_best_channel(best_channel)
    like_best_channels.delete(best_channel)
  end

  def like_best_channel?(best_channel)
    like_best_channels.include?(best_channel)
  end

  def like_best_video(best_video)
    like_best_videos << best_video unless like_best_video?(best_video)
  end

  def dislike_best_video(best_video)
    like_best_videos.delete(best_video)
  end

  def like_best_video?(best_video)
    like_best_videos.include?(best_video)
  end

  def add_or_delete_channels(channel_list)
    old_channels = channels - channel_list
    new_channels = channel_list - channels

    old_channels.each { |channel| channels.delete(channel) }
    new_channels.each { |channel| channels << channel }
  end

  def add_or_delete_videos(video_list)
    old_videos = videos - video_list
    new_videos = video_list - videos

    old_videos.each { |video| videos.delete(video) }
    new_videos.each { |video| videos << video }
  end

  def update_favorite_channels(channels)
    return false unless channels.count == 3

    if favorite_channels.present?
      best_channels.each do |best_channel|
        best_channel.best_channels_favorites.delete_all
        best_channel.delete
      end
    end
    channels.each_with_index do |channel, index|
      best_channels.create(channel:, rank: index + 1)
    end
  end

  def update_favorite_videos(videos)
    return false unless videos.count == 3

    if favorite_videos.present?
      best_videos.each do |best_video|
        best_video.best_videos_favorites.delete_all
        best_video.delete
      end
    end
    videos.each_with_index do |video, index|
      best_videos.create(video:, rank: index + 1)
    end
  end

  private

  def downcase_email
    email.downcase!
  end
end
