class UsersController < ApplicationController
  skip_before_action :require_login, only: %i[index show channels videos playlists contents following follower]
  before_action :set_user, only: %i[show update channels videos playlists contents following follower]
  before_action :not_authenticated_guest_user, only: %i[edit update destroy]

  def index
    @search_users_form = SearchUsersForm.new(search_params)
    @users = @search_users_form.search.page(params[:page])
  end

  def show
    @best_channels = @user.best_channels.order(rank: :asc)
    @best_videos = @user.best_videos.order(rank: :asc)
  end

  def edit
    @user = EditUsersForm.new(current_user)
  end

  def update
    @user = EditUsersForm.new(current_user, update_user_params)
    if @user.update(update_user_params)
      redirect_to current_user, success: t('.success')
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    User.find(params[:id]).destroy!
    redirect_to root_url, status: :see_other, success: t('.success')
  end

  def channels
    @channels = @user.subscription_channels_with_public.page(params[:page])
  end

  def videos
    @videos = @user.popular_videos_with_public.page(params[:page]).per(8)
  end

  def playlists
    @user_playlists = @user.user_playlists.where(is_public: true).page(params[:page]).per(8)
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

  def update_user_params
    params.require(:edit_users_form).permit(:name, :profile, :age, :age_is_public, :gender, :gender_is_public, :avatar, :avatar_cache, categories: [])
  end

  def search_params
    params[:q]&.permit(:name, :users_generation, :category_title, :channel_id)
  end

  def set_user
    @user = User.find(params[:id])
  end

  def not_authenticated_guest_user
    redirect_to videos_url, warning: 'ゲストユーザーは使用できません'
  end
end
