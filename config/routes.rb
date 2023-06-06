Rails.application.routes.draw do
  devise_for :users do
    get '/users/sign_out' => 'devise/sessions#destroy', :as => :destroy_user_session, via: [:get, :delete]
  end
  root to: "flats#index"
  resources :flats, only: [:index, :show, :new, :create]
  get 'users/:id/flats/new', to: "flats#new", as: "new_flats"
  post 'flats', to: 'flats#create'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
