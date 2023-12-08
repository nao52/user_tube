require 'rails_helper'

RSpec.describe BestChannel, type: :model do
  let(:user) { create(:user) }
  let(:channel) { create(:channel) }

  describe 'バリデーションチェック' do
    it '設定したすべてのバリデーションが機能しているか' do
      best_channel = user.best_channels.build(channel: channel, rank: 1)
      expect(best_channel).to be_valid
      expect(best_channel.errors).to be_empty
    end

    it 'channel_idがない場合にバリデーションが機能してinvalidになるか' do
      best_channel_without_channel_id = user.best_channels.build(channel: nil, rank: 1)
      expect(best_channel_without_channel_id).to_not be_valid
      expect(best_channel_without_channel_id.errors).to_not be_empty
    end

    it 'rankがない場合にバリデーションが機能してinvalidになるか' do
      best_channel_without_rank = user.best_channels.build(channel: channel, rank: nil)
      expect(best_channel_without_rank).to_not be_valid
      expect(best_channel_without_rank.errors).to_not be_empty
    end

    it 'user_idがない場合にバリデーションが機能してinvalidになるか' do
      best_channel_without_user_id = BestChannel.new(channel: channel, rank: 1)
      expect(best_channel_without_user_id).to_not be_valid
      expect(best_channel_without_user_id.errors).to_not be_empty
    end

    it 'ユーザーが同じチャンネルを選択した場合にバリデーションが機能してinvalidになるか' do
      best_channel = user.best_channels.create(channel: channel, rank: 1)
      duplicate_best_channel = best_channel.dup
      expect(duplicate_best_channel).to be_invalid
      expect(duplicate_best_channel.errors).to_not be_empty
    end

    it 'ユーザーが同じランクを複数の動画に選択した場合にバリデーションが機能してinvalidになるか' do
      other_channel = create(:channel)
      best_channel_1 = user.best_channels.create(channel: channel, rank: 1)
      best_channel_2 = user.best_channels.build(channel: other_channel, rank: 1)
      expect(best_channel_2).to be_invalid
      expect(best_channel_2.errors).to_not be_empty
    end
  end
end
