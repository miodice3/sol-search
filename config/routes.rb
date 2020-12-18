Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  
  
  resources :users
  resources :assets
  resources :contracts
  # resources :solarArray
  resources :location
  
  
  get '/success', to: 'sessions#success'
  get '/logout', to: 'sessions#logout'

  get '/login', to: 'sessions#login'
  post '/login', to: 'sessions#login_post'

  get '/signup', to: 'sessions#signup'
  get 'auth/:provider/callback', to: 'sessions#googleAuth'
  #get ‘auth/failure’, to: redirect(‘/’)
  
end
