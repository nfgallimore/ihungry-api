class AddUniqueConstraintToIngredientsRecipes < ActiveRecord::Migration[5.2]
  def change
    add_index :ingredients_recipes, [:ingredient_id, :recipe_id], :unique => true
  end
end
