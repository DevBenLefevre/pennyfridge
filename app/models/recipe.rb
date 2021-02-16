class Recipe < ApplicationRecord
  has_many :ingredients, dependent: :destroy
  scope :rated_more_than, ->(rate) { where("rate >= ?", rate) }

  BASIC_INGREDIENTS = %w{ sel poivre eau }

  def self.get_by_ingredients(ingredients)
    ingredients = ingredients.map(&:downcase) - BASIC_INGREDIENTS

    matches = Ingredient.none
    
    ingredients.each do |ingredient|
      matches = matches.or(Ingredient.with_name(ingredient))
    end

    Recipe.select('recipes.*, count(ingredients.name) as count_name, (count(ingredients.recipe_id)*100/recipes.ingredients_count) as pertinence')
          .preload(:ingredients)
          .joins(:ingredients)
          .merge(matches)
          .group('recipes.id')
          .order('pertinence desc')
  end
end