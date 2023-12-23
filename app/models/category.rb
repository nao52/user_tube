class Category < ApplicationRecord
  validates :title, presence: true, uniqueness: true, numericality: { only_integer: true }

  # カテゴリータイトル
  enum title: {
    film_and_animation: 1, # 映画とアニメ
    autos_and_vehicles: 2, # 自動車と乗り物
    music: 10, # 音楽
    pets_and_animals: 15, # ペットと動物
    sports: 17, # スポーツ
    travel_and_events: 19, # 旅行とイベント
    gaming: 20, # ゲーム
    people_and_blogs: 22, # ブログ
    comedy: 23, # コメディー
    entertainment: 24, # エンターテイメント
    news_and_politics: 25, # ニュースと政治
    howto_and_style: 26, # ハウツーとスタイル
    education: 27, # 教育
    science_and_technology: 28, # 科学と技術
    nonprofits_and_activism: 29, # 非営利団体と社会活動
    else: 99 # その他
  }
end
