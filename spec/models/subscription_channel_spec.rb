require 'rails_helper'

RSpec.describe SubscriptionChannel, type: :model do
  let(:user) { create(:user) }
  let(:channel) { create(:channel) }

  describe 'バリデーションチェック' do    
    it '設定したすべてのバリデーションが機能しているか' do
      subscription_channel = user.subscription_channels.build(channel: channel)
      expect(subscription_channel).to be_valid
      expect(subscription_channel.errors).to be_empty
    end

    it 'channel_idがない場合にバリデーションが機能してinvalidになるか' do
      subscription_channel_without_channel_id = user.subscription_channels.build(channel: nil)
      expect(subscription_channel_without_channel_id).to be_invalid
      expect(subscription_channel_without_channel_id.errors).to_not be_empty
    end

    it 'user_idがない場合にバリデーションが機能してinvalidになるか' do
      subscription_channel_without_user_id = SubscriptionChannel.new(user: nil, channel: channel)
      expect(subscription_channel_without_user_id).to be_invalid
      expect(subscription_channel_without_user_id.errors).to_not be_empty
    end
  end
end
