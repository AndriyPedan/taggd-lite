Rails.application.routes.draw do
  devise_for :users, controllers: {
    omniauth_callbacks: 'users/omniauth_callbacks'
  }

  root 'pages#index'

  resources :after_signup, only: %i(show update)
  resources :subscriptions, only: :create

  namespace :dashboard do
    resources :instagram_media, only: [:index, :create]
    resources :media
  end
end
