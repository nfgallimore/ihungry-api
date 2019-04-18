class CreateJoinTableIngredientsUpcs < ActiveRecord::Migration[5.2]
  def change
    create_join_table :ingredients, :upcs do |t|
      # t.index [:ingredient_id, :upc_id]
      # t.index [:upc_id, :ingredient_id]
    end
  end
end
