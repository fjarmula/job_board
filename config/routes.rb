Rails.application.routes.draw do
  devise_for :recruiter, controllers: {
    registrations: "recruiters/registrations"
  }
  get "home/index"
  resource :session, only: [ :new, :create, :destroy ]
  resources :users, only: [ :new, :create, :edit, :update ]

  get "login", to: "sessions#new"
  delete "logout", to: "sessions#destroy"
  get "signup", to: "users#new"

  namespace :api do
    namespace :v1 do
      get "companies/check_exists", to: "companies#check_exists"
    end
  end

  resources :companies, only: [ :show, :edit, :update ]
  resources :recruiters, only: [ :show ]

  resources :passwords, param: :token

  resources :job_offers, only: [ :index, :show, :new, :create ] do
    resources :job_applications, only: [ :create ]
  end

  root "home#index"

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check
end
