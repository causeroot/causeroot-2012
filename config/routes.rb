Mensch::Application.routes.draw do
  resources :sites

  resources :scrapers

  resources :challenges

  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }

  root :to => 'challenges#index'
end
