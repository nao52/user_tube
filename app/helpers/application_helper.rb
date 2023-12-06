module ApplicationHelper
  def page_title(title = '')
    base_title = 'ユーザーチューブ'
    title.present? ? "#{title} | #{base_title}" : base_title
  end

  def current_user?(user)
    logged_in? && current_user == user
  end
end
