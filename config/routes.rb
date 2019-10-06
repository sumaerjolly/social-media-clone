Rails.application.routes.draw do
  devise_for :users, :controllers => { :registrations => "user/registrations" }
  as :user do
    authenticated :user do
      root 'posts#index', as: :authenticated_root
    end
    unauthenticated do
      root 'posts#index', as: :unauthenticated_root
    end
  end
  resources :users, only: [:show,:index]
  resources :posts
end
