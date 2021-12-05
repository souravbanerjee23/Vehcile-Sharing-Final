Rails.application.routes.draw do
  resources :rents
  resources :rides

  root 'home#index'
  get '/viewrides', to: "rents#viewrides"
  get '/about', to:"about#index"
  #get "/otp" to: 
  get '/register/passengers/authenticate', to: 'passengers#authenticate'
  
  post '/register/passengers', to:  'passengers#show'
  post "/register/passengers/authenticate", to: "passengers#authenticate"
  patch "/register/passengers/authenticate", to: "passengers#authenticate"
  patch "/register/owners/authenticate", to: "owners#authenticate"
  post "/register/passengers/authenticate", to: "passengers#authenticate"
  post "/register/owners/authenticate", to: "owners#authenticate"
  get '/register/passengers', to:'passengers#new'
  #post '/register/passengers', to:'passengers#show'
  get '/register/owners', to:'owners#new'
  post '/register/owners', to:'owners#show'
  get '/login/passengers', to:'session#new'
  post '/login/passengers', to:'session#create'
  get '/login/owners', to:'ownersession#new'
  post '/login/owners', to:'ownersession#create'
  delete '/passengers/logout', to: "session#destroy"
  delete '/owners/logout', to: "ownersession#destroy"
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end