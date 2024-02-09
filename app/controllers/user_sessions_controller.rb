class UserSessionsController < ApplicationController
  skip_before_action :require_login, only: %i[new create]

  def new; end

  def create
    auth = request.env['omniauth.auth']

    @user = User.find_by(email: auth.info.email)
    @user = User.create!(auth_user_params(auth)) if @user.nil?

    auto_login(@user)
    redirect_to videos_url, success: t('.success')
  end

  def destroy
    logout
    redirect_to root_path, success: t('.success'), status: :see_other
  end

  private

  def auth_user_params(auth)
    password = generate_password(8)
    {
      name: auth.info.name,
      email: auth.info.email,
      password:,
      password_confirmation: password
    }
  end

  def generate_password(length)
    lowercase_letters = ('a'..'z').to_a
    uppercase_letters = ('A'..'Z').to_a
    numbers = (0..9).to_a
    all_characters = lowercase_letters + uppercase_letters + numbers
    Array.new(length) { all_characters.sample }.join
  end
end
