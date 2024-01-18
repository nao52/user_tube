class StaticPagesController < ApplicationController
  def top
    redirect_to channels_user_path(current_user) if logged_in?
  end

  def privacypolicy; end

  def terms; end
end
