Rails.application.routes.draw do
  root to: 'pages#home'
  resources :apartments, only: %i[index show] do
    resources :reviews, only: :create
  end
end
