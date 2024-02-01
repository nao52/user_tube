class SearchChannelsForm
  include ActiveModel::Model
  include ActiveModel::Attributes

  attribute :name, :string
  attribute :description, :string

  def search
    relation = Channel.distinct.with_users

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

  def names
    name.present? ? name.split(nil) : []
  end

  def description_words
    description.present? ? description.split(nil) : []
  end
end
