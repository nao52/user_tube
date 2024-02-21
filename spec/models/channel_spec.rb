require 'rails_helper'

RSpec.describe Channel, type: :model do
  describe 'バリデーションチェック' do
    it '設定したすべてのバリデーションが機能しているか' do
      channel = build(:channel)
      expect(channel).to be_valid
      expect(channel.errors).to be_empty
    end

    it 'チャンネルIDがない場合にバリデーションが機能してinvalidになるか' do
      channel_without_channel_id = build(:channel, channel_id: "")
      expect(channel_without_channel_id).to be_invalid
      expect(channel_without_channel_id.errors).to_not be_empty
    end

    it 'チャンネルIDがすでに登録されている場合にvalidationが機能してinvalidになるか' do
      channel = create(:channel)
      duplicate_channel = channel.dup
      expect(duplicate_channel).to be_invalid
      expect(duplicate_channel.errors).to_not be_empty
    end

    it 'チャンネル名がない場合にバリデーションが機能してinvalidになるか' do
      channel_without_name = build(:channel, name: "")
      expect(channel_without_name).to be_invalid
      expect(channel_without_name.errors).to_not be_empty
    end

    it '登録者数がない場合にバリデーションが機能してinvalidになるか' do
      channel_without_subscriber_count = build(:channel, subscriber_count: nil)
      expect(channel_without_subscriber_count).to be_invalid
      expect(channel_without_subscriber_count.errors).to_not be_empty
    end

    it '登録者数で整数以外の値が入力された場合にバリデーションが機能してinvalidになるか' do
      invalid_values = ["テスト", -5, 1.2]
      invalid_values.each do |invalid_value|
        channel_with_invalid_subscriber_count = build(:channel, subscriber_count: invalid_value)
        expect(channel_with_invalid_subscriber_count).to be_invalid
        expect(channel_with_invalid_subscriber_count.errors).to_not be_empty
      end
    end
  end
end
