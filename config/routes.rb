Rails.application.routes.draw do
  devise_for :users, :controllers => { :registrations => "user/registrations", :omniauth_callbacks => 'users/omniauth_callbacks' }

  as :user do
    authenticated :user do
      root 'posts#index', as: :authenticated_root
    end
    unauthenticated do
      root 'posts#index', as: :unauthenticated_root
    end
  end
  resources :users, only: [:show,:index]
  resources :posts do 
    resources :comments, :likes
  end

  resources :friendships
  delete "/delete_friend", to: "friendships#destroy" 
  delete "/cancel_friend", to: "friendships#cancel"
  delete "/reject_friend", to: "friendships#reject"  
  patch "/confirm_friend", to: "friendships#confirm" 

end
