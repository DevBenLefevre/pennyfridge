class RecipesController < ApplicationController
  
  # GET /recipes or /recipes.json
  def index
    if !params[:ingredients].present? || params[:ingredients].none?
      @recipes = Recipe.order('RANDOM()').limit(50)
      return
    end

    @recipes = Recipe.none

    params[:ingredients].each do |ingredient|
      @recipes = @recipes.or(Recipe.with_ingredient(ingredient))
    end

  rescue => e
    puts e.inspect
  end
end



    #@recipes = Recipe.where("ARRAY[?]::varchar[] @> ingredients", ["%lait%", "%crème%"])
    #@recipes = Recipe.where("ingredients && ARRAY[?]::varchar[]", ["1kg d'agneau", "300g de riz", "24 abricots secs", "1cuillère à soupe de sucre en poudre", "50g de matière grasse (saindoux, beurre ou huile)", "100g de beurre", "75cl de bouillon", "Poivre", "Sel"])
    #@recipes = Recipe.where("ingredients && ARRAY[?]::varchar[]", ["Sel"])

    #@recipes = Recipe.where("ingredients @> ARRAY[?]::varchar[]", ["lait", "crème"])

    #@recipes = Recipe.where("array_to_string(ingredients, '||') LIKE :ingredients", ingredients: "%riz%")
    #@recipes = Recipe.where("? = ANY(ingredients)", "1kg d'agneau")