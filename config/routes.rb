Rails.application.routes.draw do
  get 'users/show'
  devise_for :users, :controllers => { :registrations => "user/registrations" }
  as :user do
    authenticated :user do
      root 'welcome#index', as: :authenticated_root
    end
    unauthenticated do
      root 'welcome#index', as: :unauthenticated_root
    end
  end
  resources :users, only: [:show]
end
