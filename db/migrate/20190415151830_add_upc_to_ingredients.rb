class AddUpcToIngredients < ActiveRecord::Migration[5.2]
  def change
    add_column :ingredients, :upc, :string
  end
end
