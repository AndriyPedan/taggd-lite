Rails.application.routes.draw do
  devise_for :retailers, controllers: {
    omniauth_callbacks: 'retailers/omniauth_callbacks'
  }

  root 'pages#index'

end
