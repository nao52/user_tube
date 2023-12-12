require 'rails_helper'

RSpec.describe "UserContents", type: :system do
  describe 'ユーザー詳細' do
    let!(:user) { create(:user, password: 'password') }

    context 'ユーザーの登録チャンネル一覧を表示' do
      before do
        35.times do
          channel = create(:channel)
          user.subscription_channels.create(channel: channel, is_public: true)
        end
      end

      it 'ユーザーの登録チャンネル一覧が表示される' do
        visit channels_user_path(user)
        user.channels.page(1).each do |channel|
          expect(page).to have_selector "#channel-name-#{channel.id}", text: channel.name
        end
        expect(page).to have_selector '.active', text: '登録チャンネル'
        expect(page).to have_title page_title("#{user.name}の登録チャンネル"), exact: true
      end
    end

    context 'ユーザーの高評価した動画一覧を表示' do
      before do
        35.times do
          video = create(:video)
          user.popular_videos.create(video: video, is_public: true)
        end
      end

      it 'ユーザーの高評価した動画一覧が表示される' do
        visit videos_user_path(user)
        user.videos.page(1).per(8).each do |video|
          expect(page).to have_selector "#video-title-#{video.id}", text: video.title
        end
        expect(page).to have_selector '.active', text: '高評価した動画'
        expect(page).to have_title page_title("#{user.name}の高評価動画"), exact: true
      end
    end

    context 'ユーザーの投稿一覧を表示' do
      before do
        35.times do
          create(:content)
        end
      end

      it 'ユーザーの投稿一覧が表示される' do
        visit contents_user_path(user)
        user.contents.page(1).per(8).each do |content|
          expect(page).to have_selector "#content-feedback-#{content.id}", text: "感想：#{content.feedback}"
        end
        expect(page).to have_selector '.active', text: '投稿'
        expect(page).to have_title page_title("#{user.name}のコンテンツ"), exact: true
      end
    end

    context 'ユーザーのフォロー一覧 / フォロワー一覧を表示' do
      before do
        35.times do
          new_user = create(:user)
          user.active_relationships.create(followed_id: new_user.id)
          new_user.active_relationships.create(followed_id: user.id)
        end
      end

      it 'フォローしているユーザー一覧が表示される' do
        visit following_user_path(user)
        user.following.page(1).each do |user|
          expect(page).to have_selector "#user-name-#{user.id}", text: user.name
        end
        expect(page).to have_selector '.active', text: 'フォロー'
        expect(page).to have_title page_title("#{user.name}のフォロー"), exact: true
      end

      it 'フォローしているユーザー一覧が表示される' do
        visit follower_user_path(user)
        click_link 'フォロワー'
        user.followers.page(1).each do |user|
          expect(page).to have_selector "#user-name-#{user.id}", text: user.name
        end
        expect(page).to have_selector '.active', text: 'フォロワー'
        expect(page).to have_title page_title("#{user.name}のフォロワー"), exact: true
      end
    end
  end
end
