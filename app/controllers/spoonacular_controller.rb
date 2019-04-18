require 'httparty'
require 'json'

class SpoonacularController < ApplicationController
  before_action :setup

  # GET /spoonacular
  def recipes
    # create the url with params
    ingredients_param = ""
    for i in 0 ... @ingredients.size - 1
      ingredients_param << CGI.escape(@ingredients[i].title.downcase) << "%2c"
    end
    ingredients_param << CGI.escape(@ingredients[@ingredients.size - 1].title.downcase)

    number_param = 5
    ranking_param = 1
    ignore_pantry_param = false
    url =  "https://spoonacular-recipe-food-nutrition-v1.p.rapidapi.com/recipes/findByIngredients?" + 
           "number=#{number_param}" + 
           "&ranking=#{ranking_param}" +
           "&ignorePantry=#{ignore_pantry_param}" +
           "&ingredients=#{ingredients_param}" 


    response = HTTParty.get(url, :headers => @rapidapi_header)
    recipes = JSON.parse(response.body)

    # file = File.open "misc/recipes.json"
    # recipes = JSON.parse(file.read)
    # file.close

    if (recipe_params[:filter] == 'true')
      # filter recipes with missing ingredients
      recipes = recipes.select{ |recipe| recipe['missedIngredientCount'] == 0}

      # filter recipes requiring more ingredient than user has
      recipes = recipes.select do |r|
        user_has_ingredient_quantities_to_make_recipe(r)
      end
    end

    render json: recipes
  end

  # GET /spoonacular/info
  def recipe_info
    url = "https://spoonacular-recipe-food-nutrition-v1.p.rapidapi.com/recipes/#{recipe_params[:id]}/information"
    response = HTTParty.get(url, :headers => @rapidapi_header)
    info = JSON.parse(response.body)
    render json: info
  end

  private

  # converts user_ingredient into api ingredient unit
  def convert_unit(user_ingredient, api_ingredient_unit)
    url = "https://spoonacular-recipe-food-nutrition-v1.p.rapidapi.com/recipes/convert?" +
    "sourceUnit=#{user_ingredient.unit}&sourceAmount=#{user_ingredient.quantity}" +
    "&ingredientName=#{user_ingredient.title}&targetUnit=#{api_ingredient_unit}"
    response = HTTParty.get(url, :headers => @rapidapi_header)
    data = JSON.parse(response.body)
    puts data
    data['targetAmount']
  end

  # get matching ingredient
  def get_user_ingredient(spoonacular_ingredient)
    ingredients = @ingredients.select{ |i| 
      # if ingredient title is substring of spoonacular ingredient name
      i.title.singularize.downcase.in? spoonacular_ingredient['name'].singularize.downcase }

    if ingredients.size == 1
      puts "#{ingredients[0].title.singularize.downcase} matched with " +
           "#{spoonacular_ingredient['name'].singularize.downcase}"
       ingredients[0]

    elsif ingredients.size > 1
      raise StandardError, 'More than one ingredient matched'
    else
      raise StandardError, 'No ingredient matched'
    end
  end

  #filter recipe requiring more ingredient than user has
  def user_has_ingredient_quantities_to_make_recipe(recipe)
    recipe['usedIngredients'].none? { |i| 
      convert_unit(get_user_ingredient(i), i['unit']).to_f < i['amount'].to_f } 
  end

  # set the different request headers
  def setup
    @rapidapi_header = { 
      "X-RapidAPI-Host" => "spoonacular-recipe-food-nutrition-v1.p.rapidapi.com",
      "X-RapidAPI-Key" => "e20da5f30amsh2c5e4accedfa8e3p16b473jsnf1abb9f13716",
      "Content-Type" => "application/x-www-form-urlencoded"
    }

    @ingredients = Ingredient.joins(:user_ingredients).where(user_ingredients: 
      { user_id: session[:current_user].id })
  end

  def recipe_params
    params.permit(:id, :q, :filter)
  end

end
