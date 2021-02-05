class RecipesController < ApplicationController
  
  # GET /recipes or /recipes.json
  def index
    if params[:ingredients].blank?
      @recipes = Recipe.order('RANDOM()').limit(50)
      return
    end

    @recipes = Recipe.none

    params[:ingredients].each do |ingredient|
      @recipes = @recipes.or(Recipe.with_ingredient(ingredient))
    end

    if params[:rate].present?
      @recipes = @recipes.rated_more_than(params[:rate])
    end

  rescue => e
    @recipes = []
    puts e.inspect
  end
end