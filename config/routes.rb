Rails.application.routes.draw do
  resources :rents
  resources :rides
  root 'home#index'
  get '/about', to:"about#index"
  get '/register/passengers', to:'passengers#new'
  post '/register/passengers', to:'passengers#show'
  get '/register/owners', to:'owners#new'
  post '/register/owners', to:'owners#show'
  get '/login/passengers', to:'session#new'
  post '/login/passengers', to:'session#create'
  get '/login/owners', to:'ownersession#new'
  post '/login/owners', to:'ownersession#create'
  delete "logout", to: "session#destroy"
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
