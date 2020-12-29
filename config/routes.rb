Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  get '/locations/mylocations', to: 'locations#mylocations'
  get '/contracts/consumer', to: 'contracts#consumer'
  get '/contracts/owner', to: 'contracts#owner'

  root "application#aboutus"

  resources :users
  resources :contracts
  resources :locations

  resources :locations, only: [:show] do
    # nested resource for contracts
    resources :contracts, only: [:new, :show, :index]
  end
#for new, look the nested routes up and plug into <%= link_to "add contract" new_catagory_item_path(c) %>
#

  get '/feedbacks/thankyou', to: 'feedbacks#thankyou'
  resources :feedbacks
  
  get '/aboutus', to: 'application#aboutus'
  
  get '/logout', to: 'sessions#logout'

  get '/login', to: 'sessions#login'
  post '/login', to: 'sessions#login_post'

  get '/signup', to: 'sessions#signup'
  get 'auth/:provider/callback', to: 'sessions#googleAuth'
  #get ‘auth/failure’, to: redirect(‘/’)
  
end
