Rails.application.routes.draw do
  devise_for :users do
    get '/users/sign_out' => 'devise/sessions#destroy', :as => :destroy_user_session, via: [:get, :delete]
  end
  root to: "flats#index"
  resources :flats, only: [:index, :show, :new, :create] do
    resources :bookings, only: [:new, :create]
  end
  get 'users/:id/flats/new', to: "flats#new", as: "new_flats"
  post 'flats', to: 'flats#create'
  get 'users/:id/bookings/index', to: "bookings#index", as: "my_bookings"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
