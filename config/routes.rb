Rails.application.routes.draw do
  root to: 'visitors#index'

  devise_for :users
  resources :users
  resources :contacts

  get 'dashboard' => 'dashboard#index'
  get 'dashboard/index'
end
