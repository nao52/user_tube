require 'rails_helper'

RSpec.describe BestVideo, type: :model do
  describe 'バリデーションチェック' do
    it '設定したすべてのバリデーションが機能しているか' do
      best_video = build(:best_video)
      expect(best_video).to be_valid
      expect(best_video.errors).to be_empty
    end

    it '動画IDがない場合にバリデーションが機能してinvalidになるか' do
      best_video_without_video_id = build(:best_video, video: nil)
      expect(best_video_without_video_id).to_not be_valid
      expect(best_video_without_video_id.errors).to_not be_empty
    end

    it 'ユーザーIDがない場合にバリデーションが機能してinvalidになるか' do
      best_video_without_user_id = build(:best_video, user: nil)
      expect(best_video_without_user_id).to_not be_valid
      expect(best_video_without_user_id.errors).to_not be_empty
    end

    it 'ランクがない場合にバリデーションが機能してinvalidになるか' do
      best_video_without_rank = build(:best_video, rank: nil)
      expect(best_video_without_rank).to_not be_valid
      expect(best_video_without_rank.errors).to_not be_empty
    end

    it 'ランクに指定の値以外が入力された場合にバリデーションが機能してinvalidになるか' do
      invalid_ranks = ["test", -2, 0, 1.5, 4]
      invalid_ranks.each do |invalid_rank|
        best_video_with_invalid_rank = build(:best_video, rank: invalid_rank)
        expect(best_video_with_invalid_rank).to_not be_valid
        expect(best_video_with_invalid_rank.errors).to_not be_empty
      end
    end

    it 'ユーザーが同じ動画を選択した場合にバリデーションが機能してinvalidになるか' do
      best_video = create(:best_video)
      duplicate_best_video = best_video.dup
      duplicate_best_video.rank = 2
      expect(duplicate_best_video).to be_invalid
      expect(duplicate_best_video.errors).to_not be_empty
    end

    it 'ユーザーが同じランクを指定した場合にバリデーションが機能してinvalidになるか' do
      best_video = create(:best_video)
      duplicate_best_video = best_video.dup
      duplicate_best_video.video = create(:video)
      expect(duplicate_best_video).to be_invalid
      expect(duplicate_best_video.errors).to_not be_empty
    end

    it '1人のユーザーが4つ以上動画を登録しようとした場合にバリデーションが機能してinvalidになるか' do
      user = create(:user)
      create(:best_video_rank_1, user: user)
      create(:best_video_rank_2, user: user)
      create(:best_video_rank_3, user: user)

      (1..3).each do |n|
        best_video = build(:best_video, user: user, rank: n)
        expect(best_video).to be_invalid
        expect(best_video.errors).to_not be_empty
      end
    end
  end
end
