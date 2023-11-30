require 'rails_helper'

RSpec.describe "StaticPages", type: :system do
  let(:user) { create(:user, password: 'password') }

  describe 'ページ遷移の確認' do
    describe 'ログイン前' do
      context 'トップページにアクセスする' do
        it 'アクセスが成功する' do
          visit root_path
          expect(page).to have_title page_title(''), exact: true
          expect(page).to have_link 'ユーザーチューブ', href: root_path
          expect(page).to have_link 'ユーザー登録', href: signup_path
          expect(page).to have_link 'ログイン', href: login_path
          expect(page).to have_link 'ユーザー一覧', href: users_path
          expect(page).to have_link 'チャンネル一覧', href: '#'
          expect(page).to have_link '高評価動画一覧', href: '#'
          expect(page).to have_link '投稿一覧', href: '#'
          expect(page).to have_link '新着コンテンツ一覧', href: '#'
          expect(page).to have_link '実際に使ってみる！', href: '#'
          expect(page).to have_link 'トップページ', href: '#'
          expect(page).to have_link '利用規約', href: '#'
          expect(page).to have_link 'プライバシーポリシー', href: '#'
          expect(page).to have_link 'GitHub', href: '#'
          expect(page).to have_link 'Qiita', href: '#'
          expect(page).to have_link 'wantedly', href: '#'
        end
      end
    end

    describe 'ログイン後' do
      context 'トップページにアクセスする' do
        it 'アクセスが成功する' do
          login_as(user)
          click_link 'ユーザーチューブ'
          expect(page).to have_title page_title(''), exact: true
          expect(page).to have_link 'ユーザーチューブ', href: root_path
          expect(page).to have_link user.name, href: '#'
          expect(page).to have_link 'ユーザー一覧', href: users_path
          expect(page).to have_link 'チャンネル一覧', href: '#'
          expect(page).to have_link '高評価動画一覧', href: '#'
          expect(page).to have_link '投稿一覧', href: '#'
          expect(page).to have_link '新着コンテンツ一覧', href: '#'
          expect(page).to have_link '実際に使ってみる！', href: '#'
          expect(page).to have_link 'トップページ', href: '#'
          expect(page).to have_link '利用規約', href: '#'
          expect(page).to have_link 'プライバシーポリシー', href: '#'
          expect(page).to have_link 'GitHub', href: '#'
          expect(page).to have_link 'Qiita', href: '#'
          expect(page).to have_link 'wantedly', href: '#'
          click_link user.name
          expect(page).to have_link 'マイページ', href: '#'
          expect(page).to have_link 'ユーザーの編集', href: edit_user_path(user)
          expect(page).to have_link 'ログアウト', href: logout_path
        end
      end
    end
  end
end
