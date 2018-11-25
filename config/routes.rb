Rails.application.routes.draw do
  
  devise_for :users
  
  #create a root with autorization needed
  authenticated :user do
    root to: "dashboard#index", as: :authenticated_root
  end

  #root for unauthenticated users
  unauthenticated :user do
    root to: "home#index"
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
