Rails.application.routes.draw do
  get 'bookings/new'
  get 'bookings/create'
  get 'bookings/show'
  devise_for :users
  root to: "flats#index"
  resources :flats, only: [:index, :new, :create, :show] do
    resources :bookings, only: [:new, :create, :show]
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
