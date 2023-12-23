class EditUsersForm
  include ActiveModel::Model
  include ActiveModel::Attributes

  attribute :name, default: ''
  attribute :email, default: ''
  attribute :age, default: nil
  attribute :gender, default: ''
  attribute :profile, default: ''
  attribute :avatar, default: ''
  attribute :avatar_cache, default: ''
  attribute :categories, default: []

  validates :name, presence: true, length: { maximum: 50 }
  validates :email, presence: true, length: { maximum: 255 }, format: { with: /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i }
  validates :age, allow_nil: true, numericality: { only_integer: true, in: 13..100 }
  validates :gender, presence: true
  validates :profile, length: { maximum: 400 }
  validate :categories_3_or_less

  def initialize(user, attributes = {})
    @user = user
    super(default_attributes.merge(attributes))
  end

  def update(user_params)
    return false if invalid?

    ActiveRecord::Base.transaction do
      if user_params[:categories].present?
        @user.categories.delete_all
        user_params[:categories].each do |category|
          @user.categories << Category.find_by(title: category)
        end
        user_params.delete(:categories)
      end
      @user.update(user_params)
      true
    rescue ActiveRecord::Rollback
      false
    end
  end

  def avatar_url
    @user.avatar_url
  end

  private

  def default_attributes
    {
      'name' => @user.attributes['name'],
      'email' => @user.attributes['email'],
      'age' => @user.attributes['age'],
      'gender' => @user.attributes['gender'],
      'profile' => @user.attributes['profile'],
      'avatar' => @user.attributes['avatar'],
      'avatar_cache' => @user.attributes['avatar_cache'],
      'categories' => @user.categories.map(&:title)
    }
  end

  def categories_3_or_less
    return false unless categories.present?

    errors.add(:categories, 'は3つまで選択可能です') if categories.size > 3
  end
end
