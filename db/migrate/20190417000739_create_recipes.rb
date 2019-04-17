class CreateRecipes < ActiveRecord::Migration[5.2]
  def change
    create_table :recipes do |t|
      t.string :name
      t.string :raw_text
      t.string :url
      t.string :image
      t.decimal :rating
      t.string :source

      t.timestamps
    end
  end
end
