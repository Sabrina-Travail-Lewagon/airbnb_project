Rails.application.routes.draw do
  devise_for :users do
    get '/users/sign_out' => 'devise/sessions#destroy', :as => :destroy_user_session, via: [:get, :delete]
  end

  root to: "flats#index"
  resources :flats, only: [:index, :new, :create, :show]
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
