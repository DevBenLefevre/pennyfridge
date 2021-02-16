class RecipesController < ApplicationController
  
  # GET /recipes or /recipes.json
  def index
    if params[:ingredients].blank?
      @recipes = Recipe.order('RANDOM()').limit(50)
      return
    end

    @recipes = Recipe.get_by_ingredients(params[:ingredients].dup).limit(50)
  rescue => e
    @recipes = []
    logger.error(e.inspect)
  end
end