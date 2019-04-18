class IngredientsController < ApplicationController
  before_action :set_ingredient, only: [:show, :update, :destroy]
  
  # GET /ingredients
  def index
    @ingredients = Ingredient.all.where({ user: session[:current_user].id })
    render json: @ingredients
  end

  # GET /ingredients/1
  def show
    if @ingredient.user_id != session[:current_user].id
      render json: { error: 'Not Authorized' }, status: 401
    else
      render json: @ingredient
    end
  end

  # POST /ingredients
    def create

      # create the upc
      @upc = Upc.new do |u|
        u.upc_string = ingredient_params[:upc]
      end

      # create the ingredient
      @ingredient = Ingredient.new do |i|
        i.quantity = ingredient_params[:quantity]
        i.unit = ingredient_params[:unit]
        i.title = ingredient_params[:title]
      end

      # create the ingredient_upc
      @ingredient.upcs << @upc

      # create the user_ingredient
      @user_ingredient = UserIngredient.new do |ui|
        ui.quantity_left = ingredient_params[:quantity_left]
        ui.quantity_left_unit = ingredient_params[:quantity_left_unit]
        ui.user = session[:current_user]
        ui.ingredient = @ingredient
      end

      begin
        ActiveRecord::Base.transaction do
          success = @upc.save && @ingredient.save && @user_ingredient.save
          num = 1
        end
      rescue ActiveRecord::RecordNotUnique => e
        render json: { message: 'Duplicate record' }, status: :unprocessable_entity
        return
      end

      if success
        render json: num, status: :created, location: @ingredient
      else
        render json: @ingredient.errors, status: :unprocessable_entity
      end
    end 

  # PATCH/PUT /ingredients/1
  def update
    if @ingredient.user_id != session[:current_user].id
      render json: { error: 'Not Authorized' }, status: 401
    elsif @ingredient.update(ingredient_params)
      render json: @ingredient
    else
      render json: @ingredient.errors, status: :unprocessable_entity
    end
  end

  # DELETE /ingredients/1
  def destroy
    if @ingredient.user_id != session[:current_user].id
      render json: { error: 'Not Authorized' }, status: 401
    else
      @ingredient.destroy
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_ingredient
      @ingredient = Ingredient.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def ingredient_params
      params.permit(:title, :quantity, :unit, :upc, :quantity_left, :quantity_left_unit)
    end
end
