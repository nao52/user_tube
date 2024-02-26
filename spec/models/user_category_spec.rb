require 'rails_helper'

RSpec.describe UserCategory, type: :model do
  describe 'バリデーションチェック' do
    it '設定したすべてのバリデーションが機能しているか' do
      user_category = build(:user_category)
      expect(user_category).to be_valid
      expect(user_category.errors).to be_empty
    end

    it 'ユーザーIDがない場合にバリデーションが機能してinvalidになるか' do
      user_category_without_user_id = build(:user_category, user: nil)
      expect(user_category_without_user_id).to be_invalid
      expect(user_category_without_user_id.errors).to_not be_empty
    end

    it 'カテゴリーIDがない場合にバリデーションが機能してinvalidになるか' do
      user_category_without_category_id = build(:user_category, category: nil)
      expect(user_category_without_category_id).to be_invalid
      expect(user_category_without_category_id.errors).to_not be_empty
    end

    it 'ユーザーIDとカテゴリーIDの組み合わせが重複した場合にバリデーションが機能してinvalidになるか' do
      user_category = create(:user_category)
      duplicate_user_category = user_category.dup
      expect(duplicate_user_category).to be_invalid
      expect(duplicate_user_category.errors).to_not be_empty
    end

    it '同じユーザーIDのレコードを4つ以上作成しようとした場合にバリデーションが機能してinvalidになるか' do
      test_user = create(:user)
      Category.titles.values.take(3).each do |category_title|
        category = create(:category, title: category_title)
        create(:user_category, user: test_user, category: category)
      end

      user_category = build(:user_category, user: test_user)
      expect(user_category).to be_invalid
      expect(user_category.errors).to_not be_empty
    end
  end
end
