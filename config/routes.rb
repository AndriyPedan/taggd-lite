Rails.application.routes.draw do
  devise_for :users, controllers: {
    omniauth_callbacks: 'users/omniauth_callbacks'
  }

  root 'pages#index'

  resources :after_signup, only: %i(show update)
  resources :subscriptions, only: :create
end
