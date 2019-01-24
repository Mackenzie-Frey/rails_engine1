Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :transactions, only: :show
      resources :merchants, only: :show
      resources :items, only: :show
      resources :invoices, only: :show
      resources :invoice_items, only: :show
      resources :customers, only: :show
    end
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
