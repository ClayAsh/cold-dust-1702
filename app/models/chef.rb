class Chef <ApplicationRecord
  validates_presence_of :name
  has_many :dishes
  has_many :dish_ingredients, through: :dishes 
  has_many :ingredients, through: :dish_ingredients

  def unique_ingredients
    self.ingredients.select(:name).distinct.pluck(:name)
  end

  def most_popular_ingredients
    ingredients
    .select("ingredients.*, count(ingredients.name) as count ")
    .group(:id)
    .order(count: :desc)
    .limit(3)
    .pluck(:name)
  end
end
