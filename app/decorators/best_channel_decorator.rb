class BestChannelDecorator < ApplicationDecorator
  delegate_all

  def likes_count
    best_channels_favorites.size
  end
end
