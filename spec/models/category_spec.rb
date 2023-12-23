require 'rails_helper'

RSpec.describe Category, type: :model do
  describe "バリデーションチェック" do
    it "設定したすべてのバリデーションが機能しているか" do
      category = build(:category)
      expect(category).to be_valid
      expect(category.errors).to be_empty
    end

    it "titleがない場合にバリデーションが機能してinvalidになるか" do
      category_without_title = build(:category, title: nil)
      expect(category_without_title).to be_invalid
      expect(category_without_title.errors).to_not be_empty
    end

    it "titleがすでに登録されている場合にvalidationが機能してinvalidになるか" do
      category = create(:category)
      duplicate_category = category.dup
      expect(duplicate_category).to be_invalid
      expect(duplicate_category.errors).to_not be_empty
    end
  end

  describe "enumが適切に機能しているか" do
    it "タイトルについて適切な値が出力されるか" do
      category_list = {
        "0" => "その他",
        "1" => "映画とアニメ",
        "2" => "自動車と乗り物",
        "10" => "音楽",
        "15" => "ペットと動物",
        "17" => "スポーツ",
        "19" => "旅行とイベント",
        "20" => "ゲーム",
        "22" => "ブログ",
        "23" => "コメディー",
        "24" => "エンターテイメント",
        "25" => "ニュースと政治",
        "26" => "ハウツーとスタイル",
        "27" => "教育",
        "28" => "科学と技術",
        "29" => "非営利団体と社会活動"
      }
      category_list.each do |key, value|
        category = create(:category, title: key.to_i)
        expect(category.title_i18n).to eq value
      end
    end
  end
end
