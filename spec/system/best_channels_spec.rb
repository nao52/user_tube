require 'rails_helper'

RSpec.describe "BestChannels", type: :system do
  let(:user) { create(:user, password: 'password') }

  before do
    6.times do |n|
      channel = create(:channel)
      user.subscription_channels.create(channel: channel)
      next if (n) > 3
      user.best_channels.create(channel: channel, rank: n + 1)
    end
  end

  describe 'ログイン前' do
    describe 'ユーザー詳細画面にアクセスする' do
      it '「好きなチャンネル」の編集ボタンが表示されない' do
        visit channels_user_path(user)
        expect(page).to have_title page_title("#{user.name}の登録チャンネル"), exact: true
        expect(page).to_not have_selector '#edit-best-channels', text: '編集'
      end

      it '好きなチャンネルBest3が表示される' do
        visit channels_user_path(user)
        expect(page).to have_title page_title("#{user.name}の登録チャンネル"), exact: true
        user.favorite_channels.order(rank: :asc).each { |channel| expect(page).to have_selector "#best-channel-#{channel.id}", text: channel.name }
      end
    end

    describe '好きなチャンネルBEST3の編集ページにアクセスする' do
      it 'ログインページにリダイレクトする' do
        visit edit_best_channels_path
        expect(page).to have_content 'ログインしてください'
        expect(page).to have_title page_title('ログイン'), exact: true
        expect(current_path).to eq login_path
      end
    end
  end

  describe 'ログイン後' do  
    before { login_as(user) }

    describe 'マイページにアクセスする' do
      it '「好きなチャンネル」の編集ボタンが表示される' do
        click_link user.name
        click_link 'マイページ'
        expect(page).to have_title page_title("#{user.name}の登録チャンネル"), exact: true
        expect(page).to have_selector '#edit-best-channels', text: '編集'
      end

      it '好きなチャンネルBest3が表示される' do
        click_link user.name
        click_link 'マイページ'
        expect(page).to have_title page_title("#{user.name}の登録チャンネル"), exact: true
        user.favorite_channels.order(rank: :asc).each { |channel| expect(page).to have_selector "#best-channel-#{channel.id}", text: channel.name }
      end
    end

    describe 'ログインユーザー以外のユーザー詳細画面にアクセスする' do
      it '「好きなチャンネル」の編集ボタンが表示されない' do
        other_user = create(:user, password: 'password')
        visit channels_user_path(other_user)
        expect(page).to have_title page_title("#{other_user.name}の登録チャンネル"), exact: true
        expect(page).to_not have_selector '#edit-best-channels', text: '編集'
      end
    end

    describe '好きなチャンネルBEST3の編集ページにアクセスする' do
      let(:not_best_channels) { user.channels.order(created_at: :desc).take(3) }
      
      it 'アクセスが成功する' do
        click_link user.name
        click_link 'マイページ'
        find('#edit-best-channels').click
        expect(page).to have_title page_title('好きなチャンネルBEST3の編集'), exact: true
      end

      context 'キャンセルボタンをクリックする' do
        it 'ユーザー詳細(登録チャンネル)ページに遷移する' do
          click_link user.name
          click_link 'マイページ'
          find('#edit-best-channels').click
          click_link 'キャンセル'
          expect(page).to have_title page_title("#{user.name}の登録チャンネル"), exact: true
        end

        it '好きなチャンネルBest3が更新されない' do
          click_link user.name
          click_link 'マイページ'
          find('#edit-best-channels').click
          not_best_channels.each_with_index do |channel, index|
            select channel.name, from: "好きなチャンネルBEST#{index + 1}"
          end
          click_link 'キャンセル'
          not_best_channels.each { |channel| expect(page).to_not have_selector "#best-channel-#{channel.id}", text: channel.name }
        end
      end

      context '更新するボタンをクリックする' do
        it '好きなチャンネルBest3が更新させる' do
          click_link user.name
          click_link 'マイページ'
          find('#edit-best-channels').click
          not_best_channels.each_with_index do |channel, index|
            select channel.name, from: "好きなチャンネルBEST#{index + 1}"
          end
          click_button '更新する'
          expect(page).to have_title page_title("#{user.name}の登録チャンネル"), exact: true
          expect(page).to have_content '好きなチャンネルBEST3を更新しました'
          not_best_channels.each { |channel| expect(page).to have_selector "#best-channel-#{channel.id}", text: channel.name }
        end
      end
    end
  end
end
