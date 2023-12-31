class ApplicationController < ActionController::Base
  include ApplicationHelper

  add_flash_types :success, :danger, :warning, :user_params, :google_login

  def require_not_login
    redirect_to root_path, warning: '指定のページにアクセスするにはログアウトしてください' if logged_in?
  end

  private

  def not_authenticated
    redirect_to login_path, warning: 'ログインしてください'
  end
end
