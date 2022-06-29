Rails.application.routes.draw do
  root to: 'pages#home'
  get 'properties', to: 'pages#index', as: :properties

  resources :apartments, only: %i[show]
  resources :houses, only: %i[show]
end
