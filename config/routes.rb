Rails.application.routes.draw do
  devise_for :users
  root to: 'rooms#index'
  resources :rooms do
    resources :comments, only: :create
    collection do
      get 'search'
      get 'result'
    end
  end

  resources :users, only: :show
end
