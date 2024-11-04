Rails.application.routes.draw do
  # get "attendances/create"
  # get "events/index"
  # get "events/show"
  # get "events/new"
  # get "events/create"
  # get "users/new"
  # get "users/create"
  # get "users/show"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  resources :users
  resources :events
  resources :attendances

  root 'events#index'

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/*
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest

  # Defines the root path route ("/")
  # root "posts#index"
end
