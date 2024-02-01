class SearchVideosForm
  include ActiveModel::Model
  include ActiveModel::Attributes

  attribute :category_title, :string
  attribute :description, :string

  def search
    relation = Video.distinct.with_users

    relation = relation.by_category(category_id) if category_title.present?
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

  def description_words
    description.present? ? description.split(nil) : []
  end
end
