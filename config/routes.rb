Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/*
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest

  # Defines the root path route ("/")
  root "articles#index"

  #articles routes
  resources :articles do
    resources :comments
  end

  #user routes
  #route: get '/users/:id', to: 'users#show', as: :user
  get '/users/:id', to: 'users#show', as: 'user'
  get '/users/:id', to: 'users#show'
  #practice routes for the brands and products
  resources :brands, only: [:index, :show] do
    resources :products, only: [:index, :show]
  end

  #practice routes for the basket
  resource :basket, only: [:show, :update, :destroy]
  resolve("Basket") { route_for(:basket) }

  #practice routes for the photos
  resources :photos

  namespace :admin do
    resources :articles
  end

  scope '/admin' do
    resources :articles
  end

  resources :articles, module: 'admin'

  resources :magazines do
    resources :ads
  end

  resources :publishers do
    resources :magazines do
      resources :photos
    end
  end


  resources :articles, shallow: true do
    resources :comments
    resources :quotes
  end

  concern :commentable do
    resources :comments
  end

  concern :image_attachable do
    resources :images, only: :index
  end

  resources :photos do
    member do
      get 'preview'
    end
  end



end
