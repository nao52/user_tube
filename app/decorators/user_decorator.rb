class UserDecorator < ApplicationDecorator
  delegate_all

  def interesting_category
    categories.present? ? categories.map(&:title_i18n).join(' / ') : '設定なし'
  end

  def generation
    return '非公開' if age.nil?

    age < 60 ? "#{age.floor(-1)}代" : '60以上'
  end
end
