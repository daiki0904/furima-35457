Rails.application.routes.draw do
  devise_for :users
  root to: "items#index"
  resources :items do
    collection do
      get 'search'
      get 'retrieve'
      get 'result'
      get 'tagcheck'
      get 'checkresult'
    end
    resources :orders, only: [:index, :create]
  end
  get 'hashtag/:id' => 'items#hashtag', as: 'items_hashtag'
end
