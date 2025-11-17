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

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check
end
