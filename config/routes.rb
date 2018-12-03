Rails.application.routes.draw do
  devise_for :retailers

  root 'pages#index'

end
