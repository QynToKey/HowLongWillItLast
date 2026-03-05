Rails.application.routes.draw do
  get "learning_themes/new"
  get "learning_themes/create"
  get "learning_themes/index"
  get "learning_themes/edit"
  get "learning_themes/update"
  get "learning_themes/destroy"
  get "home/index"
  root "home#index"

  get "login",  to: "user_sessions#new"
  post "login",  to: "user_sessions#create"
  delete "logout", to: "user_sessions#destroy"

  resources :users, only: %i[new create]
  resources :learning_themes
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/*
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest

  # Defines the root path route ("/")
  # root "posts#index"
end
