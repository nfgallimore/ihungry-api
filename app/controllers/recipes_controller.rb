require 'httparty'

class RecipesController < ApplicationController
  def index

    headers = { 
      "X-RapidAPI-Host" => "spoonacular-recipe-food-nutrition-v1.p.rapidapi.com",
      "X-RapidAPI-Key" => "e20da5f30amsh2c5e4accedfa8e3p16b473jsnf1abb9f13716",
      "Content-Type" => "application/x-www-form-urlencoded"
    }
    
    response = HTTParty.get(
      "https://spoonacular-recipe-food-nutrition-v1.p.rapidapi.com/recipes/findByIngredients?number=5&ranking=1&ignorePantry=false&ingredients=apples%2Cflour%2Csugar", 
      :headers => headers,
    )
    render json: response
  end
end
