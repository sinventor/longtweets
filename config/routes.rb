Rails.application.routes.draw do
  resources :direct_messages, except: [:update, :edit]

  get 'public/index'

  get 'home/show'
  get 'auth/:provider/callback', to: 'sessions#create'
  get 'home/about_us'
  get 'auth/failure', to: redirect('/')
  get 'signout', to: 'sessions#destroy', as: 'signout'

  resources :tweets
  resource :home, only: [:show]
  root to: 'home#show'
end
