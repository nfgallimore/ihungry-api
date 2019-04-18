class RecipesController < ApplicationController
  before_action :set_recipe, only: [:show, :update, :destroy]

  # GET /recipes
  def index
    @recipes = Recipe.all

    render json: @recipes
  end

  # GET /recipes/1
  def show
    render json: @recipe
  end

  # POST /recipes
  def create
    @recipe = Recipe.new(recipe_params)
    create_ingredients(recipe_params[:raw_text])

    begin 
      @success = @recipe.save
    rescue ActiveRecord::RecordNotUnique => e
      render json: { message: 'Duplicate record' }, status: :unprocessable_entity
      return
    end
    
    if @success
      render json: @recipe, status: :created, location: @recipe
    else
      render json: @recipe.errors, status: :unprocessable_entity
    end

  end

  # PATCH/PUT /recipes/1
  def update
    if @recipe.update(recipe_params)
      render json: @recipe
    else
      render json: @recipe.errors, status: :unprocessable_entity
    end
  end

  # DELETE /recipes/1
  def destroy
    ingredients_recipes
    @recipe.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_recipe
      @recipe = Recipe.find(params[:id])
    end

    # get associated ingredients_recipes
    def ingredients_recipes
        Recipe.joins(:ingredients_recipes).where(recipes: { id:  @recipe.id })
    end

    def create_ingredients(raw_text)
      # see if any of the raw_text matches as food
      # create an ingredient from it
      # create an ingredient recipes association for it
    end

    # Only allow a trusted parameter "white list" through.
    def recipe_params
      params.require(:recipe).permit(:name, :raw_text, :url, :image, :rating, :source)
    end
end
