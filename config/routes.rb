Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :transactions, only: [:index, :show]
      resources :merchants, only: [:index, :show]
      resources :items, only: [:index, :show]
      resources :invoices, only: [:index, :show]
      resources :invoice_items, only: [:index, :show]
      resources :customers, only: [:index, :show]
    end
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end

# GET /api/v1/items/most_revenue?quantity=x
#
# namespace items
#   hand roll
#   get '/most_revenue' to
#   make a controller under my items
#
#   controller merchant:revenue controller
