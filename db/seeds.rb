# 初期ユーザー
FIRST_USER = User.create(
  name: "ナゲット",
  email: "nage@test.com",
  password: "nagenage",
  password_confirmation: "nagenage",
  age: 18,
  gender: 1,
  profile: "私は最初のユーザーです"
)

# テストユーザーを50人作成
50.times do |n|
  User.create(
    name: Faker::Name.name,
    email: "test#{n+1}@example.com",
    password: "password",
    password_confirmation: "password",
    profile: "私はテストユーザー(#{n+1})です"
  )  
end

# 最初のユーザー5人のコンテンツを3個ずつ作成
User.order(:created_at).take(5).each do |user|
  video_url = ["7ddyXO8knCA?si=fJoYsHnfaF-1pbv6", "9n7dz846LME?si=X6im9lycm0NI5V4S", "Mv6cNVbYuE8?si=fggXKAiAGNKVTB-5"]
  3.times do |n|
    user.contents.create(
      video_url: video_url[n],
      rating: 3,
      feedback: "テスト用のコメントです(#{n+1})"
    )
  end
end

# 初期ユーザーがすべてのユーザーをフォロー
User.all.each { |user| FIRST_USER.follow(user) }

# すべてのユーザーが初期ユーザーをフォロー
User.all.each { |user| user.follow(FIRST_USER) }

# チャンネルの作成 & 最初のユーザーの登録チャンネルに追加
["UCMJiPpN_09F0aWpQrgbc_qg", "UC67Wr_9pA4I0glIxDt_Cpyw", "UCwjx6ZG4pwCvAPSozYEWymA"].each do |channel_id|
  channel = Channel.find_or_create_by_channel_id(channel_id)
  FIRST_USER.add_subscription(channel)
end

# 動画の作成
Video.create(
  video_id: "_2G-SrAXWeg",
  title: "【4人実況】新作桃鉄３年決戦が絶望だらけで笑ってしまう『 桃太郎電鉄ワールド王決定戦 』",
  description:
   "桃鉄ワールドだいすき男たち\n桃太郎電鉄ワールド ～地球は希望でまわってる！～ 実況\n【チャンネル登録よろっぷ】　http://goo.gl/zcqUED\n【ツイッター】　http://twitter.com/kiyo_saiore\n【インスタグラム】　http://www.instagram.com/kiyo_yuusya\n\n\n【桃太郎電鉄ワールド再生リスト 】https://www.youtube.com/playlist?list=PLPUGXakMkjREGgrOZgdF8Zzwyzh_ElkHp\n\n\n【単発実況再生リスト2】https://www.youtube.com/playlist?list=PLPUGXakMkjREhhudQks_MbuLmg8OhhpF_\n\n\n【単発実況再生リスト】https://www.youtube.com/playlist?list=PLPUGXakMkjRFuBVf-jmoHr06PUdTPD6-Q\n\n\n新作等はツイッターから⇒http://twitter.com/kiyo_saiore\n\n【キヨの人生あまちゃんネル】　http://ch.nicovideo.jp/kiyo-saiore?cp...\n\n【ニコニココミュ】　http://com.nicovideo.jp/community/co217323",
  channel_id: 1
)
Video.create(
  video_id: "TCj66W8lf_s",
  title: "学生時代からの友人同士で「とんでもない質問」をしたら喧嘩になった",
  description:
   "分かり合えない男たち　　　zoom ラウンジ 実況\n【チャンネル登録よろっぷ】　http://goo.gl/zcqUED\n【ツイッター】　http://twitter.com/kiyo_saiore\n【インスタグラム】　http://www.instagram.com/kiyo_yuusya\n\n\n【単発実況再生リスト2】https://www.youtube.com/playlist?list=PLPUGXakMkjREhhudQks_MbuLmg8OhhpF_\n\n\n【単発実況再生リスト】https://www.youtube.com/playlist?list=PLPUGXakMkjRFuBVf-jmoHr06PUdTPD6-Q\n\n\n新作等はツイッターから⇒http://twitter.com/kiyo_saiore\n\n\n【キヨの人生あまちゃんネル】　http://ch.nicovideo.jp/kiyo-saiore\n\n\n【ニコニココミュ】　http://com.nicovideo.jp/community/co217323\n\n\n※私に関係がない他チャンネルの動画で私の名前を出すのはお控えください。\n　他の方に迷惑をかけないようにご視聴よろしくお願いします。",
  channel_id: 1
)
Video.create(
  video_id: "9hePYbhBSKg",
  title: "みんなで『 Among Us 』をやってるときに卑怯なことしたら大喧嘩になった",
  description:
  "容赦なくずるをする男　　　Among Us アマングアス 実況\n【チャンネル登録よろっぷ】　http://goo.gl/zcqUED\n【ツイッター】　http://twitter.com/kiyo_saiore\n【インスタグラム】　http://www.instagram.com/kiyo_yuusya\n\n\n【単発実況再生リスト2】https://www.youtube.com/playlist?list=PLPUGXakMkjREhhudQks_MbuLmg8OhhpF_\n\n\n【単発実況再生リスト】https://www.youtube.com/playlist?list=PLPUGXakMkjRFuBVf-jmoHr06PUdTPD6-Q\n\n\n新作等はツイッターから⇒http://twitter.com/kiyo_saiore\n\n\n【キヨの人生あまちゃんネル】　http://ch.nicovideo.jp/kiyo-saiore\n\n\n【ニコニココミュ】　http://com.nicovideo.jp/community/co217323\n\n\n※私に関係がない他チャンネルの動画で私の名前を出すのはお控えください。\n　他の方に迷惑をかけないようにご視聴よろしくお願いします。",
  channel_id: 1
)

# 最初のユーザーの高評価動画に追加
FIRST_USER.update_popular_videos(Video.all)

# 最初のユーザーの好きなチャンネルBEST3を設定
3.times do |n|
  channel = FIRST_USER.channels[n]
  FIRST_USER.best_channels.create(channel: channel, rank: n+1)
end

# 最初のユーザーの好きな動画BEST3を設定
3.times do |n|
  video = FIRST_USER.videos[n]
  FIRST_USER.best_videos.create(video: video, rank: n+1)
end