require 'httparty'
require 'json'

class RecipesController < ApplicationController
  before_action :setup

  # GET /recipes/spoonacular
  def spoonacular

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


    #response = HTTParty.get(url, :headers => @rapid_header)
    #recipes = JSON.parse(response.body)

    file = File.open "json/recipes.json"
    recipes = JSON.parse(file.read)
    file.close

    # filter recipes with missing ingredients
    filteredRecipes = recipes.select{ |recipe| recipe['missedIngredientCount'] == 0}

    filteredRecipes = filter_ingredient_quantity(filteredRecipes)

    render json: filteredRecipes
  end

  # GET /recipes/spoonacular/info
  def spoonacular_info
    url = "https://spoonacular-recipe-food-nutrition-v1.p.rapidapi.com/recipes/#{recipe_params[:id]}/information"
    response = HTTParty.get(url, :headers => @rapid_header)
    info = JSON.parse(response.body)
    render json: info
  end

  # GET /recipes/yummly
  def yummly
    url = "http://api.yummly.com/v1/api/recipes?q=#{CGI.escape(recipe_params[:q])}"
    response = HTTParty.get(url, :headers => @yummly_header)
    recipes = JSON.parse(response.body)
    render json: recipes
  end

  # GET /recipes/yummly/info
  def yummly_info
    url = "http://api.yummly.com/v1/api/recipe/recipe-id?#{CGI.escape(recipe_params[:id])}"
    response = HTTParty.get(url, :headers => @yummly_header)
    render json: response.body
  end

  private

  # gets converted unit for ingredient
  def convert_unit(user_ingredient, api_ingredient_unit)

  end

  # filter recipes requiring more ingredient than user has
  def filter_ingredient_quantity(recipes)
    recipes_ingredients = recipes.map { |r| 
      { r['used_ingredients']['name'], 
        r['used_ingredients']['amount'], 
        r['used_ingredients']['unit'] }

    recipes_ingredients.each do |recipe|
      if recipe.amount > @ingredients.select{ |i| recipe.name.in? i.title }[0].quantity
        puts "valid"
  end

  # sets the different request headers
  def setup
    @rapid_header = { 
      "X-RapidAPI-Host" => "spoonacular-recipe-food-nutrition-v1.p.rapidapi.com",
      "X-RapidAPI-Key" => "e20da5f30amsh2c5e4accedfa8e3p16b473jsnf1abb9f13716",
      "Content-Type" => "application/x-www-form-urlencoded"
    }

    @yummly_header = {
      "X-Yummly-App-ID" => "7127a17e",
      "X-Yummly-App-Key" => "ee221e76f5419ef4e095688b896f3030"
    }

    @ingredients = Ingredient.all.where({ user_id: session[:current_user].id }) 

  end

  def recipe_params
    params.permit(:id, :q)
  end

  class spoonacular_ingredient

  end
end
