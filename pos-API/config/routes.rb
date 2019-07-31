Rails.application.routes.draw do
  # For details on the DSL available within this file, see 
    resources :customers
    post 'customers/order', to: 'customers#order'
end
