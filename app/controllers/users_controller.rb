class UsersController < ApplicationController
  skip_before_action :require_login, only: %i[index new create confirm signup_check]
  before_action :require_not_login, only: %i[new create confirm signup_check]

  def index
    @users = User.all.page(params[:page])
  end

  def new
    params[:user] ||= flash[:user_params]
    @user = params[:user] ? User.new(user_params) : User.new
  end

  def create
    return redirect_to signup_url, user_params: user_params if params[:commit] == '入力画面に戻る'

    @user = User.create!(user_params)
    auto_login(@user)
    redirect_to root_url, success: t('.success')
  end

  def edit
    @user = current_user
  end

  def update
    @user = User.find(params[:id])

    if @user.update(user_params)
      redirect_to users_url, success: t('.success')
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def confirm
    params[:user] = flash[:user_params]
    return redirect_to root_url if params[:user].nil?

    @user = User.new(user_params)
  end

  def signup_check
    @user = User.new(user_params)
    if @user.valid?
      redirect_to(confirm_users_url, user_params:)
    else
      flash.now[:danger] = t('.danger')
      render :new, status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :age, :gender, :avatar, :avatar_cache)
  end
end
