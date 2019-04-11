Rails.application.routes.draw do
  get 'recipes', to: 'recipes#index'
  resources :ingredients
	post 'auth/register', to: 'users#register'
  post 'auth/login', to: 'users#login'
  get 'test', to: 'users#test'
end
