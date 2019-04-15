Rails.application.routes.draw do

  resources :ingredients

  get 'recipes/yummly', to: 'recipes#yummly'
  get 'recipes/yummly/info', to: 'recipes#yummly_info'

  get 'recipes/spoonacular', to: 'recipes#spoonacular'
  get 'recipes/spoonacular/info', to: 'recipes#spoonacular_info'

	post 'auth/register', to: 'users#register'
  post 'auth/login', to: 'users#login'

end
