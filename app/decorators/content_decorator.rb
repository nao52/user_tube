class ContentDecorator < ApplicationDecorator
  delegate_all

  def youtube_url(video_url)
    "https://www.youtube.com/embed/#{video_url}"
  end
end
