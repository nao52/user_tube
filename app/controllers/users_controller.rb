class UsersController < ApplicationController
  before_action :require_login, only: %i[edit update]
  before_action :require_not_login, only: %i[new create confirm signup_check]
  before_action :set_user, only: %i[update channels videos contents following follower]
  before_action :set_best_contents, only: %i[channels videos contents following follower]

  def index
    @search_users_form = SearchUsersForm.new(search_params)
    @users = @search_users_form.search.page(params[:page])
  end

  def new
    params[:user] ||= flash[:user_params]
    @user = params[:user] ? User.new(user_params) : User.new
  end

  def create
    return redirect_to signup_url, user_params: user_params if params[:commit] == '入力画面に戻る'

    @user = User.create!(user_params)
    auto_login(@user)
    redirect_to channels_user_path(@user), success: t('.success')
  end

  def edit
    @user = EditUsersForm.new(current_user)
  end

  def update
    @user = EditUsersForm.new(current_user, update_user_params)
    if @user.update(update_user_params)
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

  def channels
    @channels = @user.subscription_channels_with_public.page(params[:page])
  end

  def videos
    @videos = @user.popular_videos_with_public.page(params[:page]).per(8)
  end

  def contents
    @contents = @user.contents.page(params[:page]).per(8)
  end

  def following
    @followings = @user.following.page(params[:page])
  end

  def follower
    @followers = @user.followers.page(params[:page])
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :age, :gender, :avatar, :avatar_cache, categories: [])
  end

  def update_user_params
    params.require(:edit_users_form).permit(:name, :email, :profile, :age, :gender, :avatar, :avatar_cache, categories: [])
  end

  def search_params
    params[:q]&.permit(:name, :age, :category_title, :channel_id)
  end

  def set_user
    @user = User.find(params[:id])
  end

  def set_best_contents
    @best_channels = @user.best_channels.order(rank: :asc)
    @best_videos = @user.best_videos.order(rank: :asc)
  end
end
