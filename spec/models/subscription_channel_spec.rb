require 'rails_helper'

RSpec.describe SubscriptionChannel, type: :model do
  describe 'バリデーションチェック' do    
    it '設定したすべてのバリデーションが機能しているか' do
      subscription_channel = build(:subscription_channel)
      expect(subscription_channel).to be_valid
      expect(subscription_channel.errors).to be_empty
    end

    it 'チャンネルIDがない場合にバリデーションが機能してinvalidになるか' do
      subscription_channel_without_channel_id = build(:subscription_channel, channel: nil)
      expect(subscription_channel_without_channel_id).to be_invalid
      expect(subscription_channel_without_channel_id.errors).to_not be_empty
    end

    it 'ユーザーIDがない場合にバリデーションが機能してinvalidになるか' do
      subscription_channel_without_user_id = build(:subscription_channel, user: nil)
      expect(subscription_channel_without_user_id).to be_invalid
      expect(subscription_channel_without_user_id.errors).to_not be_empty
    end

    it 'チャンネルIDとユーザーIDの組み合わせが既に存在している場合にバリデーションが機能してinvalidになるか' do
      subscription_channel = create(:subscription_channel)
      duplicate_subscription_channel = subscription_channel.dup
      expect(duplicate_subscription_channel).to be_invalid
      expect(duplicate_subscription_channel.errors).to_not be_empty
    end
  end

  describe 'デフォルト値の確認' do
    let(:subscription_channel) { build(:subscription_channel) }

    it '公開設定のデフォルト値がfalse(非公開)になっているか' do
      expect(subscription_channel.is_public).to be_falsey
    end
  end
end
