Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      namespace :customers do
        get '/find', to: 'search#show'
      end
      resources :customers, only: [:index, :show]
  #       # namespace :items do
  #       #   get '/most_revenue?quantity=x', to: "items#some_controller"
  #       # end
  #
  #       resources :transactions, only: [:index, :show]
  #       resources :merchants, only: [:index, :show]
  #       resources :items, only: [:index, :show]
  #       resources :invoices, only: [:index, :show]
  #       resources :invoice_items, only: [:index, :show]
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
