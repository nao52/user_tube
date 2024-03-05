require 'rails_helper'

RSpec.describe ContentComment, type: :model do
  describe 'バリデーションチェック' do
    it '設定したすべてのバリデーションが機能しているか' do
      content_comment = build(:content_comment)
      expect(content_comment).to be_valid
      expect(content_comment.errors).to be_empty
    end

    it 'コメント内容がない場合にバリデーションが機能してinvalidになるか' do
      content_comment_without_body = build(:content_comment, body: '')
      expect(content_comment_without_body).to be_invalid
      expect(content_comment_without_body.errors.full_messages).to include "コメントを入力してください"
    end

    it 'コメント内容が401文字以上の場合にvalidationが機能してinvalidになるか' do
      content_comment_with_long_body = build(:content_comment, body: "a" * 401)
      expect(content_comment_with_long_body).to be_invalid
      expect(content_comment_with_long_body.errors.full_messages).to include "コメントは400文字以内で入力してください"
    end

    it 'ユーザーIDがない場合にバリデーションが機能してinvalidになるか' do
      content_comment_without_user_id = build(:content_comment, user: nil)
      expect(content_comment_without_user_id).to be_invalid
      expect(content_comment_without_user_id.errors).to_not be_empty
    end

    it 'コンテンツIDがない場合にバリデーションが機能してinvalidになるか' do
      content_comment_without_content_id = build(:content_comment, content: nil)
      expect(content_comment_without_content_id).to be_invalid
      expect(content_comment_without_content_id.errors).to_not be_empty
    end
  end
end
