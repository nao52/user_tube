require 'rails_helper'

RSpec.describe "Videos", type: :system do
  describe 'チャンネル一覧ページにアクセスする' do  
    let!(:videos) { create_list(:video, 16) }

    it 'チャンネル一覧が表示され、ページネーションが機能している' do
      visit root_path
      click_link '高評価動画一覧'
      expect(page).to have_title page_title('高評価動画一覧'), exact: true
      videos.take(8).each do |video|
        expect(page).to have_selector "#video-title-#{video.id}", text: video.title
      end
      click_link '次', match: :first
      videos.drop(8).take(8).each do |video|
        expect(page).to have_selector "#video-title-#{video.id}", text: video.title
      end
    end
  end

  describe 'チャンネル詳細ページにアクセスする' do
    let!(:video) { create(:video) }

    context 'コメント一覧ページにアクセスする' do
      let!(:comments) { create_list(:video_comment, 60, video: video) }
      
      it '動画へのコメント一覧が表示され、ページネーションが機能している' do
        visit root_path
        click_link '高評価動画一覧'
        click_link video.title
        expect(page).to have_title page_title(video.title), exact: true
        expect(page).to have_selector "#video-comment-link.active", text: 'コメント一覧'
        comments.drop(30).each do |comment|
          expect(page).to have_selector "#comment-body-#{comment.id}", text: comment.body
        end
        click_link '次', match: :first
        comments.take(30).each do |comment|
          expect(page).to have_selector "#comment-body-#{comment.id}", text: comment.body
        end
      end
    end

    context '高評価しているユーザー一覧にアクセスする' do
      before { create_list(:popular_video, 60, video: video) }

      it '動画を高評価しているユーザー一覧が表示され、ページネーションが機能している' do
        visit root_path
        click_link '高評価動画一覧'
        click_link video.title
        click_link '高評価しているユーザー一覧'
        expect(page).to have_title page_title(video.title), exact: true
        expect(page).to have_selector "#video-user-link.active", text: '高評価しているユーザー一覧'
        video.users_with_public.take(30).each do |user|
          expect(page).to have_selector "#user-name-#{user.id}", text: user.name
        end
        click_link '次', match: :first
        video.users_with_public.drop(30).each do |user|
          expect(page).to have_selector "#user-name-#{user.id}", text: user.name
        end
      end

      it '高評価動画を非公開しているユーザーが、ユーザー一覧に表示されない' do
        new_popular_video_with_public = create(:popular_video, video: video)
        new_popular_video_without_public = create(:popular_video, video: video, is_public: false)
        visit root_path
        click_link '高評価動画一覧'
        click_link video.title
        click_link '高評価しているユーザー一覧'
        click_link '最後', match: :first
        expect(page).to have_selector "#user-name-#{new_popular_video_with_public.user.id}", text: new_popular_video_with_public.user.name
        expect(page).to_not have_selector "#user-name-#{new_popular_video_without_public.user.id}", text: new_popular_video_without_public.user.name
      end
    end
  end
end
