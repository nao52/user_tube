class SearchVideosForm
  include ActiveModel::Model
  include ActiveModel::Attributes

  attribute :channel_name, :string
  attribute :category_title, :string
  attribute :description, :string
  attribute :users_generation, :integer
  attribute :following_user_ids, :string
  attribute :follow_users, :boolean

  def search
    relation = follow_users ? Video.distinct.with_following_users(following_user_ids.split(',')) : Video.distinct.with_users

    relation = relation.by_category(category_id) if category_title.present?
    relation = relation.by_users_generation(users_generation) if users_generation.present?

    channel_name_words.each do |word|
      word.downcase!
      relation = relation.channel_name_contain(word)
    end

    description_words.each do |word|
      word.downcase!
      relation = relation.description_contain(word)
    end

    relation
  end

  private

  def category_id
    Category.find_by(title: category_title).id
  end

  def channel_name_words
    channel_name.present? ? channel_name.split(nil) : []
  end

  def description_words
    description.present? ? description.split(nil) : []
  end
end
