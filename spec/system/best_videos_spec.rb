require 'rails_helper'

RSpec.describe "BestVideos", type: :system do
  let(:user) { create(:user, password: 'password') }

  before do
    6.times do |n|
      video = create(:video)
      user.popular_videos.create(video: video)
      next if (n) > 3
      user.best_videos.create(video: video, rank: n + 1)
    end
  end

  describe 'ログイン前' do
    describe 'ユーザー詳細画面にアクセスする' do
      it '「好きな動画」の編集ボタンが表示されない' do
        visit channels_user_path(user)
        expect(page).to have_title page_title("#{user.name}の登録チャンネル"), exact: true
        expect(page).to_not have_selector '#edit-best-videos', text: '編集'
      end

      it '好きな動画Best3が表示される' do
        visit channels_user_path(user)
        expect(page).to have_title page_title("#{user.name}の登録チャンネル"), exact: true
        user.favorite_videos.order(rank: :asc).each { |video| expect(page).to have_selector "#best-video-#{video.id}", text: video.title }
      end
    end

    describe '好きな動画BEST3の編集ページにアクセスする' do
      it 'ログインページにリダイレクトする' do
        visit edit_best_videos_path
        expect(page).to have_content 'ログインしてください'
        expect(page).to have_title page_title('ログイン'), exact: true
        expect(current_path).to eq login_path
      end
    end
  end

  describe 'ログイン後' do  
    before { login_as(user) }

    describe 'マイページにアクセスする' do
      it '「好きな動画Best3」の編集ボタンが表示される' do
        click_link user.name
        click_link 'マイページ'
        expect(page).to have_title page_title("#{user.name}の登録チャンネル"), exact: true
        expect(page).to have_selector '#edit-best-videos', text: '編集'
      end

      it '好きなチャンネルBest3が表示される' do
        click_link user.name
        click_link 'マイページ'
        expect(page).to have_title page_title("#{user.name}の登録チャンネル"), exact: true
        user.favorite_videos.order(rank: :asc).each { |video| expect(page).to have_selector "#best-video-#{video.id}", text: video.title }
      end
    end

    describe 'ログインユーザー以外のユーザー詳細画面にアクセスする' do
      it '「好きな動画」の編集ボタンが表示されない' do
        other_user = create(:user, password: 'password')
        visit channels_user_path(other_user)
        expect(page).to have_title page_title("#{other_user.name}の登録チャンネル"), exact: true
        expect(page).to_not have_selector '#edit-best-videos', text: '編集'
      end
    end

    describe '好きなチャンネルBEST3の編集ページにアクセスする' do
      let(:not_best_videos) { user.videos.order(created_at: :desc).take(3) }
      
      it 'アクセスが成功する' do
        click_link user.name
        click_link 'マイページ'
        find('#edit-best-videos').click
        expect(page).to have_title page_title('好きな動画BEST3の編集'), exact: true
      end

      context 'キャンセルボタンをクリックする' do
        it 'ユーザー詳細(高評価動画)ページに遷移する' do
          click_link user.name
          click_link 'マイページ'
          find('#edit-best-videos').click
          click_link 'キャンセル'
          expect(page).to have_title page_title("#{user.name}の登録チャンネル"), exact: true
        end

        it '好きな動画Best3が更新されない' do
          click_link user.name
          click_link 'マイページ'
          find('#edit-best-videos').click
          not_best_videos.each_with_index do |video, index|
            select video.title, from: "好きな動画BEST#{index + 1}"
          end
          click_link 'キャンセル'
          not_best_videos.each { |video| expect(page).to_not have_selector "#best-video-#{video.id}", text: video.title }
        end
      end

      context '更新するボタンをクリックする' do
        it '好きな動画Best3が更新させる' do
          click_link user.name
          click_link 'マイページ'
          find('#edit-best-videos').click
          not_best_videos.each_with_index do |video, index|
            select video.title, from: "好きな動画BEST#{index + 1}"
          end
          click_button '更新する'
          expect(page).to have_title page_title("#{user.name}の高評価動画"), exact: true
          expect(page).to have_content '好きな動画BEST3を更新しました'
          not_best_videos.each { |video| expect(page).to have_selector "#best-video-#{video.id}", text: video.title }
        end
      end
    end
  end
end
