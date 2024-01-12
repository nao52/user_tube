class UserDecorator < ApplicationDecorator
  delegate_all

  def interesting_category
    categories.present? ? categories.map(&:title_i18n).join(' / ') : '設定なし'
  end

  def age_and_gereration
    if generation && gender_is_public
      "年齢：#{generation} / 性別：#{gender_i18n}"
    elsif generation
      "年齢：#{generation}"
    elsif gender_is_public
      "性別：#{gender_i18n}" if gender != 'not_known'
    end
  end

  private

  def generation
    return false unless age_is_public && age

    age < 60 ? "#{age.floor(-1)}代" : '60以上'
  end
end
