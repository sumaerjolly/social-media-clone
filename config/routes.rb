Rails.application.routes.draw do
  devise_for :users, :controllers => { :registrations => "user/registrations" }
  as :user do
    authenticated :user do
      root 'posts#index', as: :authenticated_root
    end
    unauthenticated do
      root 'welcome#index', as: :unauthenticated_root
    end
  end
end
