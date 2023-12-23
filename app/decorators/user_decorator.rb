class UserDecorator < ApplicationDecorator
  delegate_all

  def interesting_category
    categories.present? ? categories.map(&:title_i18n).join(' / ') : '設定なし'
  end
end
