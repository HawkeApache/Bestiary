Rails.application.routes.draw do
  resources :comments
  resources :subjects
  resources :users
  resources :beasts

  root 'main#index'

end
