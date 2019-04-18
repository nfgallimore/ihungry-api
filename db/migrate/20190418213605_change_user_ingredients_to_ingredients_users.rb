class ChangeUserIngredientsToIngredientsUsers < ActiveRecord::Migration[5.2]
  def change
    rename_table :ingredient_users, :ingredients_users
  end
end
