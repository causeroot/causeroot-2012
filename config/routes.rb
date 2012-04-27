Mensch::Application.routes.draw do
  resources :challenges

  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }

  root :to 'home#index'
end
