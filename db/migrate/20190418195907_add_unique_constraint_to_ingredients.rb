class AddUniqueConstraintToIngredients < ActiveRecord::Migration[5.2]
  def change
    add_index :ingredients, [:title, :quantity, :unit], :unique => true
  end
end
