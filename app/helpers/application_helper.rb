module ApplicationHelper
  def page_title(title = '')
    base_title = 'ユーザーチューブ'
    title.present? ? "#{title} | #{base_title}" : base_title
  end

  def current_user?(user)
    logged_in? && current_user == user
  end

  def current_path_include?(*str)
    current_path = "#{controller.controller_path}##{controller.action_name}"
    str.map { |s| current_path.include?(s) }.include?(true)
  end
end
