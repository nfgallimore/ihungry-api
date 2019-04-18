class AddUniqueConstraintToUserIngredients < ActiveRecord::Migration[5.2]
  def change
    add_index :user_ingredients, [:quantity_left, :quantity_left_unit, :user_id, :ingredient_id], :unique => true, :name => 'user_ingredients_unique'
  end
end
