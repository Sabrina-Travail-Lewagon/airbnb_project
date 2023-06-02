Rails.application.routes.draw do
  get 'flats/index'
  get 'flats/show'
  devise_for :users
  root to: "flats#index"
  resources :flats, only: [:new, :create]
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
