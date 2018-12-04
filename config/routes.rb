Rails.application.routes.draw do
  devise_for :users, controllers: {
    omniauth_callbacks: 'users/omniauth_callbacks'
  }
  resources :after_signup, only: [:show, :update]

  root 'pages#index'

end
