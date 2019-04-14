require 'httparty'
require 'json'

class RecipesController < ApplicationController
  def index

    headers = { 
      "X-RapidAPI-Host" => "spoonacular-recipe-food-nutrition-v1.p.rapidapi.com",
      "X-RapidAPI-Key" => "e20da5f30amsh2c5e4accedfa8e3p16b473jsnf1abb9f13716",
      "Content-Type" => "application/x-www-form-urlencoded"
    }

    ingredients = Ingredient.all.where({ user_id: session[:current_user].id })
    
    ingredients_url = ""

    for i in 0 ... ingredients.size - 1
      ingredient = CGI.escape(ingredients[i].title.downcase)
      ingredients_url << ingredient << "%2c"
    end

    ingredients_url << CGI.escape(ingredients[ingredients.size - 1].title.downcase)

    number = 5
    ranking = 1
    ignore_pantry = false

    url =  "https://spoonacular-recipe-food-nutrition-v1.p.rapidapi.com/recipes/findByIngredients?" + 
           "number=#{number}" + 
           "&ranking=#{ranking}" +
           "&ignorePantry=#{ignore_pantry}" +
           "&ingredients=#{ingredients_url}" 


    response = HTTParty.get(url, :headers => headers)
    recipes = JSON.parse(response.body)
    filteredRecipes = json.select{ |recipe| recipe[:missedIngredientCount] == 0}

    render json: filteredRecipes
    
  end
end
