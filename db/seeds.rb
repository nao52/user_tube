# 初期ユーザー
User.create(
  name: "ナゲット",
  email: "nage@test.com",
  password: "nagenage",
  password_confirmation: "nagenage",
  age: 18,
  gender: 1
)

# テストユーザーを50人作成
50.times do |n|
  User.create(
    name: Faker::Name.name,
    email: "test#{n+1}@example.com",
    password: "password",
    password_confirmation: "password"
  )  
end

# 各ユーザーのコンテンツを3個ずつ作成
User.all.each do |user|
  3.times do |n|
    user.contents.create(
      video_url: "test",
      rating: 3,
      feedback: "テスト用のコメントです(#{n+1})"
    )
  end
end