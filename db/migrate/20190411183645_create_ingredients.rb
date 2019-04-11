class CreateIngredients < ActiveRecord::Migration[5.2]
  def change
    create_table :ingredients do |t|
      t.string :title
      t.decimal :quantity
      t.string :unit

      t.timestamps
    end
  end
end
