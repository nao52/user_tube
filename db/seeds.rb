# 初期ユーザー
User.create(
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