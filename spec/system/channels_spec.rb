require 'rails_helper'

RSpec.describe "Channels", type: :system do
  describe 'チャンネル一覧ページにアクセスする' do

    it 'アクセスが成功する' do
      visit root_path
      click_link 'チャンネル一覧'
      expect(page).to have_title page_title('チャンネル一覧'), exact: true
    end

    it 'チャンネル一覧が表示され、ページネーションが機能している' do
      35.times { create(:channel) }
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
end
