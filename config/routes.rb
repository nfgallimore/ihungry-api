Rails.application.routes.draw do
  resources :ingredients
	post 'auth/register', to: 'users#register'
  post 'auth/login', to: 'users#login'
  get 'test', to: 'users#test'
end
