class RecipesController < ApplicationController
  
  # GET /recipes or /recipes.json
  def index
    if params[:ingredients].blank?
      @recipes = Recipe.order('RANDOM()').limit(50)
      return
    end

    @recipes = Recipe.get_by_ingredients(params[:ingredients].dup).sort_by { |recipe| (recipe.count_name.to_f/recipe.ingredients_count) }.reverse
  rescue => e
    @recipes = []
    logger.error(e.inspect)
  end
end