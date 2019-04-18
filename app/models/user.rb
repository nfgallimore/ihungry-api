class User < ApplicationRecord
	# validations
	validates_presence_of :name, :email, :password_digest
	validates :email, uniqueness: true

	# encrypt password
	has_secure_password

  has_many :user_ingredients
  has_many :ingredients, through: :user_ingredients
end
