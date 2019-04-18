Rails.application.routes.draw do

  resources :ingredients
  resources :recipes
  resources :user_ingredients

  get 'yummly', to: 'yummly#recipes'
  get 'yummly/info', to: 'yummly#recipe_info'

  get 'spoonacular', to: 'spoonacular#recipes'
  get 'spoonacular/info', to: 'spoonacular#recipe_info'

	post 'auth/register', to: 'users#register'
  post 'auth/login', to: 'users#login'

end
