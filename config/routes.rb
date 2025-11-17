Rails.application.routes.draw do
  get "home/index"
  # Authentication
  resource :session, only: [ :new, :create, :destroy ]
  resources :users, only: [ :new, :create ]

  # Friendly alias routes (optional)
  get "login", to: "sessions#new"
  delete "logout", to: "sessions#destroy"
  get "signup", to: "users#new"

  # Password reset (from generator)
  resources :passwords, param: :token

  # Job offers
  resources :job_offers, only: [ :index, :show, :new, :create ]

  # Root
  root "home#index"
end
