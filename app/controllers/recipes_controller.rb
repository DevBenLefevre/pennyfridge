class RecipesController < ApplicationController
  
  # GET /recipes or /recipes.json
  def index
    Rails.logger.debug 1.inspect

    Rails.logger.debug params[:ingredients].inspect
    Rails.logger.debug 2.inspect
    @recipes = Recipe.all.limit(50)
  end
end
