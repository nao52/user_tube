class BestVideoDecorator < ApplicationDecorator
  delegate_all

  def likes_count
    best_videos_favorites.size
  end
end
