class User < ApplicationRecord
  authenticates_with_sorcery!

  before_save :downcase_email

  validates :password, presence: true, length: { minimum: 8 }, if: -> { new_record? || changes[:crypted_password] }
  validates :password, confirmation: true, if: -> { new_record? || changes[:crypted_password] }
  validates :password_confirmation, presence: true, if: -> { new_record? || changes[:crypted_password] }
  validates :name, presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 }, format: { with: VALID_EMAIL_REGEX }, uniqueness: true
  validates :age, allow_nil: true, numericality: { only_integer: true, in: 13..100 }
  validates :gender, presence: true

  # 性別 { 回答なし: 0, 男性: 1, 女性: 2, その他: 9 }
  enum gender: { not_known: 0, male: 1, female: 2, not_applicabel: 9 }

  private

  def downcase_email
    email.downcase!
  end
end
