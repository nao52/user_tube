require 'rails_helper'

RSpec.describe "UserContents", type: :system do
  describe 'ユーザー詳細' do

    before do
      user = create(:user, password: 'password')
      35.times do
        channel = create(:channel)
        user.add_subscription(channel)
        video = create(:video)
        user.add_popular_videos(video)
        create(:content, user: user)
        new_user = create(:user)
        user.follow(new_user)
        new_user.follow(user)
      end
    end

    let(:user) { User.first }

    context 'ユーザーの登録チャンネル一覧を表示' do
      it 'ユーザーの登録チャンネル一覧が表示される' do
        visit channels_user_path(user)
        user.channels.page(1).each do |channel|
          expect(page).to have_content channel.name
        end
        expect(page).to have_selector '.active', text: '登録チャンネル'
        expect(page).to have_title page_title("#{user.name}の登録チャンネル"), exact: true
      end
    end

    context 'ユーザーの高評価した動画一覧を表示' do
      it 'ユーザーの高評価した動画一覧が表示される' do
        visit videos_user_path(user)
        user.videos.page(1).per(8).each do |video|
          expect(page).to have_content video.title
        end
        expect(page).to have_selector '.active', text: '高評価した動画'
        expect(page).to have_title page_title("#{user.name}の高評価動画"), exact: true
      end
    end

    context 'ユーザーの投稿一覧を表示' do
      it 'ユーザーの投稿一覧が表示される' do
        visit contents_user_path(user)
        user.contents.page(1).per(8).each do |content|
          expect(page).to have_content "評価：#{"☆" * content.rating}"
          expect(page).to have_content "感想：#{content.feedback}"
        end
        expect(page).to have_selector '.active', text: '投稿'
        expect(page).to have_title page_title("#{user.name}のコンテンツ"), exact: true
      end
    end

    context 'ユーザーのフォロー一覧を表示' do
      it 'フォローしているユーザー一覧が表示される' do
        visit following_user_path(user)
        user.following.page(1).each do |user|
          expect(page).to have_content user.name
        end
        expect(page).to have_selector '.active', text: 'フォロー'
        expect(page).to have_title page_title("#{user.name}のフォロー"), exact: true
      end
    end

    context 'ユーザーのフォロワー一覧を表示' do
      it 'フォローしているユーザー一覧が表示される' do
        visit follower_user_path(user)
        click_link 'フォロワー'
        user.followers.page(1).each do |user|
          expect(page).to have_content user.name
        end
        expect(page).to have_selector '.active', text: 'フォロワー'
        expect(page).to have_title page_title("#{user.name}のフォロワー"), exact: true
      end
    end
  end
end
