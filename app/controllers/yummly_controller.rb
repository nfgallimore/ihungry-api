require 'httparty'
require 'json'

class YummlyController < ApplicationController
  before_action :setup

  # GET /yummly
  def recipes
    url = "http://api.yummly.com/v1/api/recipes?q=#{CGI.escape(recipe_params[:q])}"
    response = HTTParty.get(url, :headers => @yummly_header)
    recipes = JSON.parse(response.body)
    render json: recipes
  end

  # GET /yummly/info
  def recipe_info
    url = "http://api.yummly.com/v1/api/recipe/recipe-id?#{CGI.escape(recipe_params[:id])}"
    response = HTTParty.get(url, :headers => @yummly_header)
    render json: response.body
  end

  private

  # set the different request headers
  def setup
    @yummly_header = {
      "X-Yummly-App-ID" => "7127a17e",
      "X-Yummly-App-Key" => "ee221e76f5419ef4e095688b896f3030"
    }

    @ingredients = Ingredient.joins(:user_ingredients).where(user_ingredients: 
    { user_id: session[:current_user].id })

  end

  def recipe_params
    params.permit(:id, :q)
  end

end
