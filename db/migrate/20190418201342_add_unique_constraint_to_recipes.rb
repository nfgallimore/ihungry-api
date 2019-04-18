class AddUniqueConstraintToRecipes < ActiveRecord::Migration[5.2]
  def change
    add_index :recipes, [:name, :raw_text, :url, :image, :rating, :source], :unique => true, :name => 'recipes_unique'
  end
end
