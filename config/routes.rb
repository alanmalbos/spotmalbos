Rails.application.routes.draw do
  get 'recently_heards/create'
  devise_for :users
  
  #create a root with autorization needed
  authenticated :user do
    root to: "dashboard#index", as: :authenticated_root
    resources :search, only: [:index, :new], as: :searches
    resources :categories, only: :show
    resources :artists, only: :show
    resources :albums, only: :show do
        resources :recently_heards, only: :create
    end
    resources :favorites, only: :index
    resources :songs, only: [] do
      post "/favorite", to: "favorites#create", on: :member, defaults: { format: :js, favoritable_type: 'Song' }
      delete "/favorite", to: "favorites#destroy", on: :member, defaults: { format: :js, favoritable_type: 'Song' }
    end
  end

  #root for unauthenticated users
  unauthenticated :user do
    root to: "home#index"
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
