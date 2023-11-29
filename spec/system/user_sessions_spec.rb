require 'rails_helper'

RSpec.describe "UserSessions", type: :system do
  let(:user) { create(:user, password: 'password') }

  describe 'ログイン前' do
    context 'フォームの入力値が正常' do
      it 'ログイン処理が成功する' do
        visit root_path
        click_on 'ログイン'
        fill_in 'メールアドレス', with: user.email
        fill_in 'パスワード', with: 'password'
        click_button 'ログインする'
        expect(page).to have_content 'ログインしました'
        expect(current_path).to eq root_path
      end
    end

    context 'フォームが未入力' do
      it 'ログイン処理が失敗する' do
        visit root_path
        click_on 'ログイン'
        fill_in 'メールアドレス', with: ''
        fill_in 'パスワード', with: ''
        click_button 'ログイン'
        expect(page).to have_content 'メールアドレスまたはパスワードが異なります'
        expect(current_path).to eq login_path
      end
    end
  end

  describe 'ログイン後' do
    context 'ログアウトボタンをクリック' do
      it 'ログアウト処理が成功する' do
        login_as(user)
        click_link user.name
        click_link 'ログアウト'
        expect(page).to have_content 'ログアウトしました'
      end
    end
  end
end
