class StaticPagesController < ApplicationController
  skip_before_action :require_login

  def top
    redirect_to videos_user_path(current_user) if logged_in?
  end

  def privacypolicy; end

  def terms; end
end
