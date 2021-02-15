class Recipe < ApplicationRecord
  has_many :ingredients, dependent: :destroy
  scope :rated_more_than, ->(rate) { where("rate >= ?", rate) }
  attr_accessor :pertinence

  BASIC_INGREDIENTS = %w{ sel poivre eau }

  def self.get_by_ingredients(ingredients)
    ingredients = ingredients.map(&:downcase) - BASIC_INGREDIENTS

    subquery = Ingredient.none
    
    ingredients.each do |ingredient|
      subquery = subquery.or(Ingredient.with_name(ingredient))
    end

    subquery = subquery .select('count(ingredients.name) as count_name')
                        .group(:recipe_id)
                        .order('count_name desc')

    Recipe.select('recipes.*')
          .preload(:ingredients)
          .joins(:ingredients)
          .group('recipes.id')
          .merge(subquery)

  end
end
