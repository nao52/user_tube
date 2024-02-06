class SearchUsersForm
  include ActiveModel::Model
  include ActiveModel::Attributes

  attribute :name, :string
  attribute :users_generation, :integer
  attribute :category_title, :string
  attribute :channel_id, :integer

  def search
    relation = User.distinct

    relation = relation.by_users_generation(users_generation) if users_generation.present?
    relation = relation.by_category(category_id) if category_title.present?
    relation = relation.by_channel(channel_id) if channel_id.present?
    names.each do |name|
      name.downcase!
      relation = relation.name_contain(name)
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
end
