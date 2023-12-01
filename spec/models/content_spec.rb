require 'rails_helper'

RSpec.describe Content, type: :model do
  describe 'バリデーションチェック' do
    it '設定したすべてのバリデーションが機能しているか' do
      content = build(:content)
      expect(content).to be_valid
      expect(content.errors).to be_empty
    end

    it 'video_urlがない場合にバリデーションが機能してinvalidになるか' do
      content_without_video_url = build(:content, video_url: "")
      expect(content_without_video_url).to be_invalid
      expect(content_without_video_url.errors.full_messages).to include "動画URLを入力してください"
    end

    it 'ratingがない場合にバリデーションが機能してinvalidになるか' do
      content_without_rating = build(:content, rating: nil)
      expect(content_without_rating).to be_invalid
      expect(content_without_rating.errors.full_messages).to include "評価を入力してください"
    end

    it "ratingが1〜5以外の場合にvalidationが機能してinvalidになるか" do
      invalid_rating = [-5, 0, 6, 10]
      invalid_rating.each do |invalid_rating|
        content_with_invalid_rating = build(:content, rating: invalid_rating)
        expect(content_with_invalid_rating).to be_invalid
        expect(content_with_invalid_rating.errors.full_messages).to include "評価は1..5の範囲に含めてください"
      end
    end

    it 'feedbackがない場合にバリデーションが機能してinvalidになるか' do
      content_without_feedback = build(:content, feedback: "")
      expect(content_without_feedback).to be_invalid
      expect(content_without_feedback.errors.full_messages).to include "感想を入力してください"
    end

    it "feedbackが401文字以上の場合にvalidationが機能してinvalidになるか" do
      content_with_long_feedback = build(:content, feedback: "a" * 401)
      expect(content_with_long_feedback).to be_invalid
      expect(content_with_long_feedback.errors.full_messages).to include "感想は400文字以内で入力してください"
    end
  end
end
