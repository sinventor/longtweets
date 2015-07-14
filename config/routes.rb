Rails.application.routes.draw do
  get 'home/show'
  get 'auth/:provider/callback', to: 'sessions#create'
  get 'home/about_us'
  get 'auth/failure', to: redirect('/')
  get 'signout', to: 'sessions#destroy', as: 'signout'
  get 'tweets/new'
  get 'tweets/show'

  resources :tweets
  resource :home, only: [:show]
  root to: 'home#show'
end
