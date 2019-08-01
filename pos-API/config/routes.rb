Rails.application.routes.draw do
  # For details on the DSL available within this file, see 
    resources :customers
    resources :items
    put 'items', to: 'items#update'
    post 'customers/order', to: 'customers#order'
end
