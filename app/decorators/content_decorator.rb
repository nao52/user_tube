class ContentDecorator < ApplicationDecorator
  delegate_all

  def youtube_url(video_url)
    "https://www.youtube.com/embed/#{video_url}"
  end

  def rating(rating)
    '☆' * rating
  end

  def likes_count
    content_favorites.size
  end
end
