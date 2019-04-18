class ChangeIngredientUsersToUserIngredients < ActiveRecord::Migration[5.2]
  def change
    rename_table :ingredients_users, :user_ingredients
  end
end
