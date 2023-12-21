require 'rails_helper'

RSpec.describe UserCategory, type: :model do
  describe 'バリデーションチェック' do
    it '設定したすべてのバリデーションが機能しているか' do
      user_category = build(:user_category)
      expect(user_category).to be_valid
      expect(user_category.errors).to be_empty
    end

    it 'user_idがない場合にバリデーションが機能してinvalidになるか' do
      user_category_without_user_id = build(:user_category, user: nil)
      expect(user_category_without_user_id).to be_invalid
      expect(user_category_without_user_id.errors).to_not be_empty
    end

    it 'category_idがない場合にバリデーションが機能してinvalidになるか' do
      user_category_without_category_id = build(:user_category, category: nil)
      expect(user_category_without_category_id).to be_invalid
      expect(user_category_without_category_id.errors).to_not be_empty
    end

    it 'user_idとcategory_idの組み合わせが重複した場合にバリデーションが機能してinvalidになるか' do
      user_category = create(:user_category)
      duplicate_user_category = user_category.dup
      expect(duplicate_user_category).to be_invalid
      expect(duplicate_user_category.errors).to_not be_empty
    end
  end
end
