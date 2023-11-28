require 'rails_helper'

RSpec.describe User, type: :model do
  describe "バリデーションチェック" do
    it "設定したすべてのバリデーションが機能しているか" do
      user = build(:user)
      expect(user).to be_valid
      expect(user.errors).to be_empty
    end

    it "名前がない場合にバリデーションが機能してinvalidになるか" do
      user_without_name = build(:user, name: "")
      expect(user_without_name).to be_invalid
      expect(user_without_name.errors.full_messages).to include "ユーザー名を入力してください"
    end

    it "nameが51文字以上の場合にvalidationが機能してinvalidになるか" do
      user_with_long_name = build(:user, name: "a" * 51)
      expect(user_with_long_name).to be_invalid
      expect(user_with_long_name.errors.full_messages).to include "ユーザー名は50文字以内で入力してください"
    end

    it "メールアドレスがない場合にバリデーションが機能してinvalidになるか" do
      user_without_email = build(:user, email: "")
      expect(user_without_email).to be_invalid
      expect(user_without_email.errors.full_messages).to include "メールアドレスを入力してください"
    end

    it "emailがすでに登録されている場合にvalidationが機能してinvalidになるか" do
      user = create(:user)
      duplicate_user = user.dup
      expect(duplicate_user).to be_invalid
      expect(duplicate_user.errors.full_messages).to include "メールアドレスはすでに存在します"
    end

    it "emailが256文字以上の場合にvalidationが機能してinvalidになるか" do
      user_with_long_email = build(:user, email: "a" * 244 + "@example.com")
      expect(user_with_long_email).to be_invalid
      expect(user_with_long_email.errors.full_messages).to include "メールアドレスは255文字以内で入力してください"
    end

    it "emailのフォーマットが不正な場合にvalidationが機能してinvalidになるか" do
      invalid_addresses = %w[user@example,com user_at_foo.org user.name@example. foo@bar_baz.com foo@bar+baz.com foo@bar..com]
      invalid_addresses.each do |invalid_address|
        user_with_invalid_email = build(:user, email: invalid_address)
        expect(user_with_invalid_email).to be_invalid
        expect(user_with_invalid_email.errors.full_messages).to include "メールアドレスは不正な値です"
      end
    end

    it "passwordがない場合にvalidationが機能してinvalidになるか" do
      blank_password = ""
      user_without_password = build(:user, password: blank_password, password_confirmation: blank_password)
      expect(user_without_password).to be_invalid
      expect(user_without_password.errors.full_messages).to include "パスワードを入力してください"
    end

    it "passwordが8文字未満の場合にvalidationが機能してinvalidになるか" do
      seven_characters = "a" * 7
      user_with_short_password = build(:user, password: seven_characters, password_confirmation: seven_characters)
      expect(user_with_short_password).to be_invalid
      expect(user_with_short_password.errors.full_messages).to include "パスワードは8文字以上で入力してください"
    end

    it "passwordとpassword_confirmationが異なる場合にvalidationが機能してinvalidになるか" do
      invalid_password = "invalid_password"
      user_with_invalid_confirmation_password = build(:user, password_confirmation: invalid_password)
      expect(user_with_invalid_confirmation_password).to be_invalid
      expect(user_with_invalid_confirmation_password.errors.full_messages).to include "確認用パスワードとパスワードの入力が一致しません"
    end

    it "ageが13〜100以外の場合にvalidationが機能してinvalidになるか" do
      invalid_ages = [-1, 0, 12, 101, 150, 200]
      invalid_ages.each do |invalid_age|
        user_with_invalid_age = build(:user, age: invalid_age)
        expect(user_with_invalid_age).to be_invalid
        expect(user_with_invalid_age.errors.full_messages).to include "年齢は13..100の範囲に含めてください"
      end
    end

    it "genderがない場合にvalidationが機能してinvalidになるか" do
      user_without_gender = build(:user, gender: nil)
      expect(user_without_gender).to be_invalid
      expect(user_without_gender.errors.full_messages).to include "性別を入力してください"
    end
  end

  describe "モデルに登録されているメソッドのチェック" do
    it "emailが登録される場合に小文字に変換されているか" do
      mixed_case_email = "Foo@ExAMPle.CoM"
      user = create(:user, email: mixed_case_email)
      expect(user.email).to eq mixed_case_email.downcase
    end
  end

  describe "enumが適切に機能しているか" do
    it "性別について適切な値が出力されるか" do
      gender_list = { "0" => "回答なし", "1" => "男性", "2" => "女性", "9" => "その他" }
      gender_list.each do |key, value|
        user = create(:user, gender: key.to_i)
        expect(user.gender_i18n).to eq value
      end
    end
  end
end
