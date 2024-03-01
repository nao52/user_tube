require 'rails_helper'

RSpec.describe BestChannel, type: :model do
  describe 'バリデーションチェック' do
    it '設定したすべてのバリデーションが機能しているか' do
      best_channel = build(:best_channel)
      expect(best_channel).to be_valid
      expect(best_channel.errors).to be_empty
    end

    it 'チャンネルIDがない場合にバリデーションが機能してinvalidになるか' do
      best_channel_without_channel_id = build(:best_channel, channel: nil)
      expect(best_channel_without_channel_id).to_not be_valid
      expect(best_channel_without_channel_id.errors).to_not be_empty
    end

    it 'ユーザーIDがない場合にバリデーションが機能してinvalidになるか' do
      best_channel_without_user_id = build(:best_channel, user: nil)
      expect(best_channel_without_user_id).to_not be_valid
      expect(best_channel_without_user_id.errors).to_not be_empty
    end

    it 'ランクがない場合にバリデーションが機能してinvalidになるか' do
      best_channel_without_rank = build(:best_channel, rank: nil)
      expect(best_channel_without_rank).to_not be_valid
      expect(best_channel_without_rank.errors).to_not be_empty
    end

    it 'ランクに指定の値以外が入力された場合にバリデーションが機能してinvalidになるか' do
      invalid_ranks = ["test", -2, 0, 1.5, 4]
      invalid_ranks.each do |invalid_rank|
        best_channel_without_rank = build(:best_channel, rank: invalid_rank)
        expect(best_channel_without_rank).to_not be_valid
        expect(best_channel_without_rank.errors).to_not be_empty
      end
    end

    it 'ユーザーが同じチャンネルを選択した場合にバリデーションが機能してinvalidになるか' do
      best_channel = create(:best_channel)
      duplicate_best_channel = best_channel.dup
      expect(duplicate_best_channel).to be_invalid
      expect(duplicate_best_channel.errors).to_not be_empty
    end

    it 'ユーザーが同じランクを指定した場合にバリデーションが機能してinvalidになるか' do
      best_channel = create(:best_channel)
      duplicate_best_channel = best_channel.dup
      duplicate_best_channel.channel = create(:channel)
      expect(duplicate_best_channel).to be_invalid
      expect(duplicate_best_channel.errors).to_not be_empty
    end

    it '1人のユーザーが4つ以上チャンネルを登録しようとした場合にバリデーションが機能してinvalidになるか' do
      user = create(:user)
      create(:best_channel_rank_1, user: user)
      create(:best_channel_rank_2, user: user)
      create(:best_channel_rank_3, user: user)

      (1..3).each do |n|
        best_channel = build(:best_channel, user: user, rank: n)
        expect(best_channel).to be_invalid
        expect(best_channel.errors).to_not be_empty
      end
    end
  end
end
