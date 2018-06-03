Rails.application.routes.draw do
  resources :subjects do
    resources :comments, shallow: true
  end
  resources :users
  resources :beasts do
    resources :comments, shallow: true
  end

  root 'main#index'

end
