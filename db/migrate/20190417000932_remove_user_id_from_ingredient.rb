class RemoveUserIdFromIngredient < ActiveRecord::Migration[5.2]
  def change
    remove_column :ingredients, :user_id, :string
  end
end
