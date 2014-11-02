Rails.application.routes.draw do
  root to: 'visitors#index'

  devise_for :users
  resources :users
  resources :contacts

  get 'dashboard' => 'dashboard#index'

  get 'dashboard/index'

  post 'responses/add'

  get 'pebble_settings/:pebble_token' => "users#connect_pebble", as: 'connect_pebble_sign_in'
end
