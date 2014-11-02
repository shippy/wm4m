Rails.application.routes.draw do
  root to: 'visitors#index'

  get 'users/setup_notice', to: "users#setup_notice", as: "setup_notice"
  get 'contacts/setup', to: "contacts#setup", as: "contacts_setup"

  devise_for :users, :controllers => { :registrations => "registrations" }
  resources :users
  resources :contacts

  get 'dashboard' => 'dashboard#index'

  get 'dashboard/index'

  post 'responses/add'

  get 'pebble_settings/:pebble_token' => "users#connect_pebble", as: 'connect_pebble_sign_in'

end
