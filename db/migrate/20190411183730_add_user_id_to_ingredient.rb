class AddUserIdToIngredient < ActiveRecord::Migration[5.2]
  def change
    add_column :ingredients, :user_id, :integer
  end
end
