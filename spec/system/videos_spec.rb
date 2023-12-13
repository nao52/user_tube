require 'rails_helper'

RSpec.describe "Videos", type: :system do
  describe 'チャンネル一覧ページにアクセスする' do  
    let!(:video) { create(:video) }

    before do
      35.times { create(:video) }
    end

    it 'アクセスが成功する' do
      visit root_path
      click_link '高評価動画一覧'
      expect(page).to have_title page_title('高評価動画一覧'), exact: true
    end

    it 'チャンネル一覧が表示され、ページネーションが機能している' do
      visit videos_path
      Video.all.page(1).each do |video|
        expect(page).to have_selector "#video-title-#{video.id}", text: video.title
      end
      click_link '次', match: :first
      Video.all.page(2).each do |video|
        expect(page).to have_selector "#video-title-#{video.id}", text: video.title
      end
    end
  end
end
