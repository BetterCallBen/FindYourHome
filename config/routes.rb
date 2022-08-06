Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  get 'properties', to: 'pages#index', as: :properties

  resources :houses, only: %i[show]

  resources :apartments, only: %i[show] do
    post 'remove_favorite', to: 'apartments#remove_favorite'
    post 'add_favorite', to: 'apartments#add_favorite'
  end

  resources :researches, only: %i[create index]
end
