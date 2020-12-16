Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :users

  get '/login', to: 'sessions#login'
  get '/success', to: 'sessions#success'
  #post '/auth/:google_oauth2/callback', to: 'sessions#create'
  #get 'auth/:provider/callback', to: 'sessions#googleAuth', as: 'google_login'
  get 'auth/:provider/callback', to: 'sessions#create'
end
