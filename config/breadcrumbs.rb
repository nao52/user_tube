crumb :root do
  link "トップページ", root_path
end

crumb :user_videos do |user|
  link "#{user.name}の高評価動画", videos_user_path(user)
end

crumb :user_show do |user|
  link "プロフィール", user_path(user)
  parent :user_videos, user
end

crumb :user_edit do |user|
  link "ユーザー編集", following_user_path(user)
  parent :user_show, user
end

crumb :best_channels_edit do |user|
  link "好きなチャンネルBest3の編集", edit_best_videos_path
  parent :user_show, user
end

crumb :best_videos_edit do |user|
  link "好きな動画Best3の編集", edit_best_channels_path
  parent :user_show, user
end

crumb :following do |user|
  link "フォロー中", following_user_path(user)
  parent :user_show, user
end

crumb :follower do |user|
  link "フォロワー", follower_user_path(user)
  parent :user_show, user
end

crumb :setting_public_for_videos do |user|
  link "高評価動画の設定", edit_popular_videos_path
  parent :user_videos, user
end

crumb :user_channels do |user|
  link "#{user.name}の登録チャンネル", channels_user_path(user)
end

crumb :setting_public_for_channels do |user|
  link "登録チャンネルの設定", edit_subscription_channels_path
  parent :user_channels, user
end

crumb :user_playlists do |user|
  link "#{user.name}の登録チャンネル", playlists_user_path(user)
end

crumb :setting_public_for_playlists do |user|
  link "登録チャンネルの設定", edit_playlists_path
  parent :user_playlists, user
end