class ApplicationController < ActionController::Base
  before_action :require_login

  add_flash_types :success, :danger, :warning, :user_params

  def require_not_login
    redirect_to root_path, warning: '指定のページを開くにはログアウトしてください' if logged_in?
  end

  private

  def not_authenticated
    redirect_to login_path, warning: 'ログインしてください'
  end
end
