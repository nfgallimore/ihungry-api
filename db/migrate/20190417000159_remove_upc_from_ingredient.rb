class RemoveUpcFromIngredient < ActiveRecord::Migration[5.2]
  def change
    remove_column :ingredients, :upc, :string
  end
end
