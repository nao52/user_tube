class UserCategory < ApplicationRecord
  belongs_to :user
  belongs_to :category

  validates :user_id, uniqueness: { scope: :category_id }
  validate :max_categories_per_user_is_three

  private

  def max_categories_per_user_is_three
    errors.add(:base, 'ユーザーはカテゴリーを3つまで選択できます') if UserCategory.where(user_id:).size >= 3
  end
end
