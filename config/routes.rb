Rails.application.routes.draw do
  resources :subjects
  resources :users
  resources :beasts

  root 'main#index'

end
