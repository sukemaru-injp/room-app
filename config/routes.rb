Rails.application.routes.draw do
  devise_for :users
  root to: 'rooms#index'
  resources :rooms do
    resources :comments, only: :create
    resource :likes, only: [:create, :destroy]
    collection do
      get 'search'
      get 'result'
    end
  end

  resources :tags do
    get 'rooms', to: 'rooms#tagsearch'
  end

  resources :users, only: :show
  resources :abouts, only: [:index]
end
