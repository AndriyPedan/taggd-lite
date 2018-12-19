Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  devise_for :users, controllers: {
    omniauth_callbacks: 'users/omniauth_callbacks',
    sessions: 'users/sessions',
  }

  root 'dashboard/instagram_media#index'

  resources :after_signup, only: %i(show update)
  resources :subscriptions, only: :create

  namespace :dashboard do
    resources :instagram_media, only: %i(index create)
    resources :settings, only: :index
    resources :media do
      resources :products
    end
  end
end
