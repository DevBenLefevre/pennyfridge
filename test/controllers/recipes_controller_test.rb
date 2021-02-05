require "test_helper"

class RecipesControllerTest < ActionDispatch::IntegrationTest
  setup do
    Rails.application.load_seed
  end

  test "should get index" do
    get recipes_url
    assert_response :success
  end

  test "should return only recipes with provided ingredients" do
    get recipes_url, params: { ingredients: ['jambon', 'gruyere'] }
  end

end
