require 'rails_helper'

RSpec.describe VideoCategory, type: :model do
  describe 'バリデーションチェック' do
    it '設定したすべてのバリデーションが機能しているか' do
      video_category = build(:video_category)
      expect(video_category).to be_valid
      expect(video_category.errors).to be_empty
    end

    it 'video_idがない場合にバリデーションが機能してinvalidになるか' do
      video_category_without_video_id = build(:video_category, video: nil)
      expect(video_category_without_video_id).to be_invalid
      expect(video_category_without_video_id.errors).to_not be_empty
    end

    it 'category_idがない場合にバリデーションが機能してinvalidになるか' do
      video_category_without_category_id = build(:video_category, category: nil)
      expect(video_category_without_category_id).to be_invalid
      expect(video_category_without_category_id.errors).to_not be_empty
    end

    it 'video_idとcategory_idの組み合わせが重複した場合にバリデーションが機能してinvalidになるか' do
      video_category = create(:video_category)
      duplicate_video_category = video_category.dup
      expect(duplicate_video_category).to be_invalid
      expect(duplicate_video_category.errors).to_not be_empty
    end
  end
end
