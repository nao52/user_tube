module ApplicationHelper
  def page_title(title = '')
    base_title = 'ユーザーチューブ'
    title.present? ? "#{title} | #{base_title}" : base_title
  end

  def current_user?(user)
    logged_in? && current_user == user
  end

  def guest_user?
    guest_user = User.find_by(email: 'nage@test.com')
    current_user?(guest_user)
  end

  def admin_user?
    current_user.role_i18n == '管理者'
  end

  def current_path_include?(*str)
    current_path = "#{controller.controller_path}##{controller.action_name}"
    str.map { |s| current_path.include?(s) }.include?(true)
  end

  def generations_hash
    generations_hash = {}

    (1..9).each do |i|
      age = i * 10
      key = "#{age}代".to_sym
      generations_hash[key] = age
    end

    generations_hash
  end
end
