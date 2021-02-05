require "test_helper"

class RecipesControllerTest < ActionDispatch::IntegrationTest
  setup do
    
    ActiveRecord::Base.connection.execute("TRUNCATE recipes")
    
    records = File.open("./db/seeds/recipes.json").read
    bulk_array = []
    nb_lines = 0

    records.each_line do |record|
      if (nb_lines > 50)
        break
      end

      parsed = JSON.parse(record)
      parsed['ingredients'] = parsed['ingredients'].join(', ')
      bulk_array << parsed
      nb_lines = nb_lines + 1

      rescue JSON::ParserError => e
          next
    end

    Recipe.insert_all(bulk_array)
  end

  test "should get index" do
    get recipes_url
    assert_response :success
  end

  test "should return recipes with provided ingredient" do
    get recipes_url, params: { ingredients: ['dinde'] }
    assert_select 'p.result-ok', "2 recettes correspondantes"
  end


  test "should return recipes with provided ingredients" do
    get recipes_url, params: { ingredients: ['dinde', 'riz'] }
    assert_select 'p.result-ok', "6 recettes correspondantes"
  end

  test "should not return recipes when a wrong ingredient is provided" do
    get recipes_url, params: { ingredients: ['not-a-good-ingredient'] }
    assert_select 'p.result-nok', "Aucune recette trouvée. N'y a t'il pas autre chose dans votre frigo ? ;-)"
  end

end
