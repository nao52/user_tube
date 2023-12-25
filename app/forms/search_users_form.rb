class SearchUsersForm
  include ActiveModel::Model
  include ActiveModel::Attributes

  attribute :name, :string
  attribute :age, :integer
  attribute :category, :string
  attribute :channel_id, :integer

  def search
    relation = User.distinct

    relation = relation.by_age(age) if age.present?
    relation = relation.by_category(category) if category.present?
    relation = relation.by_channel(channel_id) if channel_id.present?
    names.each do |name|
      relation = relation.name_contain(name)
    end
    relation
  end

  private

  def names
    name.present? ? name.split(nil) : []
  end
end
