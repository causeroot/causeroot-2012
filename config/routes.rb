Carrio::Application.routes.draw do
  resources :iterate_rules

  resources :sites

  resources :scrapers

  resources :challenges

  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }

  root :to => 'challenges#index'
end
