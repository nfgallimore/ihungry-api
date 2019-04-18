class Ingredient < ApplicationRecord
  has_many :user_ingredients
  has_many :users, through :user_ingredients
  has_and_belongs_to_many :upcs
  has_and_belongs_to_many :recipes
  
end
