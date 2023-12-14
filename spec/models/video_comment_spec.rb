require 'rails_helper'

RSpec.describe VideoComment, type: :model do
  describe 'バリデーションチェック' do
    it '設定したすべてのバリデーションが機能しているか' do
      video_comment = build(:video_comment)
      expect(video_comment).to be_valid
      expect(video_comment.errors).to be_empty
    end

    it 'bodyがない場合にバリデーションが機能してinvalidになるか' do
      video_comment_without_body = build(:video_comment, body: '')
      expect(video_comment_without_body).to be_invalid
      expect(video_comment_without_body.errors.full_messages).to include "コメントを入力してください"
    end

    it 'bodyが401文字以上の場合にvalidationが機能してinvalidになるか' do
      video_comment_with_long_body = build(:video_comment, body: "a" * 401)
      expect(video_comment_with_long_body).to be_invalid
      expect(video_comment_with_long_body.errors.full_messages).to include "コメントは400文字以内で入力してください"
    end

    it 'user_idがない場合にバリデーションが機能してinvalidになるか' do
      video_comment_without_user_id = build(:video_comment, user: nil)
      expect(video_comment_without_user_id).to be_invalid
      expect(video_comment_without_user_id.errors).to_not be_empty
    end

    it 'video_idがない場合にバリデーションが機能してinvalidになるか' do
      video_comment_without_video_id = build(:video_comment, video: nil)
      expect(video_comment_without_video_id).to be_invalid
      expect(video_comment_without_video_id.errors).to_not be_empty
    end
  end
end
