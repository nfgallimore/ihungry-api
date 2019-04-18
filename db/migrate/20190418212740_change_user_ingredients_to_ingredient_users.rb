class ChangeUserIngredientsToIngredientUsers < ActiveRecord::Migration[5.2]
  def change
      rename_table :user_ingredients, :ingredient_users
  end
end
