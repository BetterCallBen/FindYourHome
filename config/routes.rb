Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  get 'properties', to: 'pages#index', as: :properties

  resources :apartments, only: %i[show]
  resources :houses, only: %i[show]
  resources :researches, only: %i[create]
end
