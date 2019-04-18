class UserIngredientsController < ApplicationController
  before_action :set_user_ingredient, only: [:show, :update, :destroy]

  # GET /user_ingredients
  def index
    @user_ingredients = UserIngredient.all

    render json: @user_ingredients
  end

  # GET /user_ingredients/1
  def show
    render json: @user_ingredient
  end

  # POST /user_ingredients
  def create
    @user_ingredient = UserIngredient.new(user_ingredient_params)

    begin 
      @success = @user_ingredient.save
    rescue ActiveRecord::RecordNotUnique => e
      render json: { message: 'Duplicate record' }, status: :unprocessable_entity
      return
    end

    if @success
      render json: @user_ingredient, status: :created, location: @user_ingredient
    else
      render json: @user_ingredient.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /user_ingredients/1
  def update
    if @user_ingredient.update(user_ingredient_params)
      render json: @user_ingredient
    else
      render json: @user_ingredient.errors, status: :unprocessable_entity
    end
  end

  # DELETE /user_ingredients/1
  def destroy
    @user_ingredient.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user_ingredient
      @user_ingredient = UserIngredient.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def user_ingredient_params
      params.require(:user_ingredient).permit(:id, :quantity_left, :quantity_left_unit, :user_id, :ingredient_id)
    end
end
