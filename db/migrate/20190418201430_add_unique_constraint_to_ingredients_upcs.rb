class AddUniqueConstraintToIngredientsUpcs < ActiveRecord::Migration[5.2]
  def change
    add_index :ingredients_upcs, [:ingredient_id, :upc_id], :unique => true
  end
end
