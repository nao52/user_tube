require 'rails_helper'

RSpec.describe "Channels", type: :system do
  describe 'チャンネル一覧ページにアクセスする' do  
    let!(:channel) { create(:channel) }

    before do
      35.times { create(:channel) }
    end

    it 'アクセスが成功する' do
      visit root_path
      click_link 'チャンネル一覧'
      expect(page).to have_title page_title('チャンネル一覧'), exact: true
    end

    it 'チャンネル一覧が表示され、ページネーションが機能している' do
      visit channels_path
      Channel.all.page(1).each do |channel|
        expect(page).to have_selector "#channel-name-#{channel.id}", text: channel.name
      end
      click_link '次', match: :first
      Channel.all.page(2).each do |channel|
        expect(page).to have_selector "#channel-name-#{channel.id}", text: channel.name
      end
    end
  end

  describe 'チャンネル詳細ページにアクセスする' do
    let!(:channel) { create(:channel) }

    context 'コメント一覧を表示' do
      before do
        35.times { create(:channel_comment, channel: channel) }
      end

      it 'アクセスが成功する' do
        visit channels_path
        click_link channel.name
        expect(page).to have_title page_title(channel.name), exact: true
        expect(page).to have_selector "#channel-comment-link.active", text: 'コメント一覧'
      end

      it 'コメント一覧が表示され、ページネーションが機能している' do
        visit channel_path(channel)
        channel.channel_comments.includes(:user).page(1).each do |comment|
          expect(page).to have_selector "#comment-body-#{comment.id}", text: comment.body
        end
        click_link '次', match: :first
        channel.channel_comments.includes(:user).page(2).each do |comment|
          expect(page).to have_selector "#comment-body-#{comment.id}", text: comment.body
        end
      end
    end

    context '高評価された動画一覧を表示' do
      let!(:channel) { create(:channel) }

      before do
        35.times { create(:video, channel: channel) }
      end

      it 'アクセスが成功する' do
        visit channels_path
        click_link channel.name
        find("#channel-video-link").click
        expect(page).to have_selector "#channel-video-link.active", text: '高評価された動画'
      end

      it '高評価された動画一覧が表示され、ページネーションが機能している' do
        visit channel_path(channel)
        find("#channel-video-link").click
        channel.videos.page(1).each do |video|
          expect(page).to have_selector "#video-title-#{video.id}", text: video.title
        end
        click_link '次', match: :first
        channel.videos.page(2).each do |video|
          expect(page).to have_selector "#video-title-#{video.id}", text: video.title
        end
      end
    end

    context 'ユーザー一覧を表示' do
      let!(:channel) { create(:channel) }

      before do
        35.times do
          user = create(:user)
          user.subscription_channels.create(channel: channel)
        end
      end

      it 'アクセスが成功する' do
        visit channels_path
        click_link channel.name
        find("#channel-user-link").click
        expect(page).to have_selector "#channel-user-link.active", text: 'ユーザー一覧'
      end

      it 'ユーザー一覧が表示され、ページネーションが機能している' do
        visit channel_path(channel)
        find("#channel-user-link").click
        channel.users.page(1).each do |user|
          expect(page).to have_selector "#user-name-#{user.id}", text: user.name
        end
        click_link '次', match: :first
        channel.users.page(2).each do |user|
          expect(page).to have_selector "#user-name-#{user.id}", text: user.name
        end
      end
    end
  end
end
