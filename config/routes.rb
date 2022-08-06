Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  get 'properties', to: 'pages#index', as: :properties

  resources :houses, only: %i[show] do
    member do
      post 'add_favorite', to: 'houses#add_favorite'
      post 'remove_favorite', to: 'houses#remove_favorite'
    end
  end

  resources :apartments, only: %i[show] do
    member do
      post 'add_favorite', to: 'apartments#add_favorite'
      post 'remove_favorite', to: 'apartments#remove_favorite'
    end
  end

  resources :researches, only: %i[create index]
end
