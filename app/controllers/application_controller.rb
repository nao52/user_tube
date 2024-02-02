class ApplicationController < ActionController::Base
  include ApplicationHelper
  before_action :require_login

  add_flash_types :success, :danger, :warning, :user_params, :google_login

  private

  def not_authenticated
    redirect_to login_path, warning: 'ログインしてください'
  end
end
