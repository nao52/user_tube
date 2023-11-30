# 初期ユーザー
User.create(
  name: "ナゲット",
  email: "nage@test.com",
  password: "nagenage",
  password_confirmation: "nagenage",
  age: 18,
  gender: 1
)

50.times do |n|
  User.create(
    name: Faker::Name.name,
    email: "test#{n+1}@example.com",
    password: "password",
    password_confirmation: "password"
  )  
end
