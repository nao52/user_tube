class ChannelDecorator < ApplicationDecorator
  delegate_all

  def categories
    videos.map { |video| video.category.title_i18n }.uniq.join(' / ')
  end
end
