require 'rails_helper'

RSpec.describe "Users", type: :system do
  describe 'ログイン前' do
    describe 'ユーザー新規登録' do
      context 'フォームの入力値が正常' do
        it 'ユーザーの新規作成が成功する' do
          visit root_path
          click_on 'ユーザー登録'
          fill_in 'ユーザー名', with: 'ナゲット'
          fill_in 'メールアドレス', with: 'email@example.com'
          fill_in 'パスワード', with: 'password'
          fill_in '確認用パスワード', with: 'password'
          select '20', from: '年齢'
          select '男性', from: '性別'
          click_button '登録する'
          expect(page).to have_title page_title('ユーザー登録(確認画面)'), exact: true
          expect(current_path).to eq confirm_users_path
          expect(page).to have_field 'ユーザー名', with: 'ナゲット'
          expect(page).to have_field 'メールアドレス', with: 'email@example.com'
          expect(page).to have_field 'パスワード', with: 'password'
          expect(page).to have_field '確認用パスワード', with: 'password'
          expect(find('#user_age_hidden', visible: false).value).to eq '20'
          expect(find('#user_gender_hidden', visible: false).value).to eq 'male'
          click_button '登録する'
          expect(page).to have_content 'ユーザー登録を行いました'
          expect(page).to_not have_selector 'a', text: 'ユーザー登録'
          expect(page).to_not have_selector 'a', text: 'ログイン'
          expect(page).to have_selector 'a', text: 'ナゲット'
          expect(current_path).to eq root_path
        end
      end

      context 'フォームの入力値が不正' do
        it 'ユーザーの新規登録が失敗する' do
          visit root_path
          click_on 'ユーザー登録'
          fill_in 'ユーザー名', with: ''
          fill_in 'メールアドレス', with: ''
          fill_in 'パスワード', with: ''
          fill_in '確認用パスワード', with: ''
          click_button '登録する'
          expect(page).to have_content 'ユーザー登録に失敗しました'
          expect(page).to have_content 'パスワードを入力してください'
          expect(page).to have_content 'パスワードは8文字以上で入力してください'
          expect(page).to have_content '確認用パスワードを入力してください'
          expect(page).to have_content 'ユーザー名を入力してください'
          expect(page).to have_content 'メールアドレスを入力してください'
          expect(page).to have_content 'メールアドレスは不正な値です'
        end
      end

      context '登録確認画面から入力画面に戻る' do
        it 'パスワードを除く入力内容が保持される' do
          visit root_path
          click_on 'ユーザー登録'
          fill_in 'ユーザー名', with: 'ナゲット'
          fill_in 'メールアドレス', with: 'email@example.com'
          fill_in 'パスワード', with: 'password'
          fill_in '確認用パスワード', with: 'password'
          select '20', from: '年齢'
          select '男性', from: '性別'
          click_button '登録する'
          click_button '入力画面に戻る'
          expect(page).to have_field 'ユーザー名', with: 'ナゲット'
          expect(page).to have_field 'メールアドレス', with: 'email@example.com'
          expect(page).to have_field 'パスワード', with: ''
          expect(page).to have_field '確認用パスワード', with: ''
          expect(page).to have_select('年齢', selected: '20')
          expect(page).to have_select('性別', selected: '男性')
          expect(current_path).to eq signup_path
        end
      end
    end

    describe 'ユーザー一覧' do
      before do
        50.times do
          create(:user)
        end
      end

      context 'ユーザー一覧ページを表示' do
        it '登録済みのユーザーが表示される' do
          visit root_path
          click_on 'ユーザー一覧'
          expect(page).to have_selector 'ul.pagination'
          User.all.page(1).each do |user|
            expect(page).to have_content user.name
          end
          click_link "次", match: :first
          User.all.page(2).each do |user|
            expect(page).to have_content user.name
          end
        end
      end
    end
  end
end
