Rails.application.routes.draw do
  resources :rides do
    put 'start_ride', to: 'rides#start_ride'
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
