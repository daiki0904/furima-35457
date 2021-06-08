Rails.application.routes.draw do
  devise_for :users
  root to: "items#index"
  resources :items do
    collection do
      get 'search'
      get 'retrieve'
      get 'result'
    end
    resources :orders, only: [:index, :create]
  end
end
