crumb :root do
  link "ユーザーの高評価動画", root_path
end

crumb :user_show do |user|
  link "プロフィール", user_path(user)
  parent :root
end

crumb :following do |user|
  link "フォロー中", following_user_path(user)
  parent :user_show, user
end

crumb :follower do |user|
  link "フォロワー", follower_user_path(user)
  parent :user_show, user
end