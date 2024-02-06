class SearchChannelsForm
  include ActiveModel::Model
  include ActiveModel::Attributes

  attribute :name, :string
  attribute :description, :string
  attribute :category_title, :string
  attribute :users_generation, :integer
  attribute :following_user_ids, :string
  attribute :follow_users, :boolean

  def search
    relation = follow_users ? Channel.distinct.with_following_users(following_user_ids.split(',')) : Channel.distinct.with_users

    relation = relation.by_category(category_id) if category_title.present?
    relation = relation.by_users_generation(users_generation) if users_generation.present?

    names.each do |name|
      name.downcase!
      relation = relation.name_contain(name)
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

  def names
    name.present? ? name.split(nil) : []
  end

  def description_words
    description.present? ? description.split(nil) : []
  end
end
