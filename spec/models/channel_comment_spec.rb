require 'rails_helper'

RSpec.describe ChannelComment, type: :model do
  describe 'バリデーションチェック' do
    it '設定したすべてのバリデーションが機能しているか' do
      channel_comment = build(:channel_comment)
      expect(channel_comment).to be_valid
      expect(channel_comment.errors).to be_empty
    end

    it 'コメント内容がない場合にバリデーションが機能してinvalidになるか' do
      channel_comment_without_body = build(:channel_comment, body: '')
      expect(channel_comment_without_body).to be_invalid
      expect(channel_comment_without_body.errors.full_messages).to include "コメントを入力してください"
    end

    it 'コメント内容が401文字以上の場合にvalidationが機能してinvalidになるか' do
      channel_comment_with_long_body = build(:channel_comment, body: "a" * 401)
      expect(channel_comment_with_long_body).to be_invalid
      expect(channel_comment_with_long_body.errors.full_messages).to include "コメントは400文字以内で入力してください"
    end

    it 'ユーザーIDがない場合にバリデーションが機能してinvalidになるか' do
      channel_comment_without_user_id = build(:channel_comment, user: nil)
      expect(channel_comment_without_user_id).to be_invalid
      expect(channel_comment_without_user_id.errors).to_not be_empty
    end

    it 'チャンネルIDがない場合にバリデーションが機能してinvalidになるか' do
      channel_comment_without_channel_id = build(:channel_comment, channel: nil)
      expect(channel_comment_without_channel_id).to be_invalid
      expect(channel_comment_without_channel_id.errors).to_not be_empty
    end
  end
end
