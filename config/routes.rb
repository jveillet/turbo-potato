Rails.application.routes.draw do
  # Starts the app on the rides list
  root 'rides#index'

  resources :rides do
    put 'start_ride', to: 'rides#start_ride'
    put 'cancel_ride', to: 'rides#cancel_ride'
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
