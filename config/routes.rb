Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      namespace :customers do
        get '/find', to: 'search#show'
        get '/find_all', to: 'search#index'
        get '/:id/invoices', to: 'invoices_of_customer#index'
        get '/:id/transactions', to: 'transactions_of_customer#index'
        get '/random', to: 'random#show'
      end
      resources :customers, only: [:index, :show]

      namespace :merchants do
        get '/find', to: 'search#show'
        get '/find_all', to: 'search#index'
        get '/most_revenue', to: 'revenue#index'
        get '/most_items', to: 'items#index'
        get '/:id/items', to: 'items_of_merchant#index'
        get '/:id/invoices', to: 'invoices_of_merchant#index'
        get '/random', to: 'random#show'
      end
      resources :merchants, only: [:index, :show]

      namespace :invoices do
        get '/find', to: 'search#show'
        get '/find_all', to: 'search#index'
        get '/:id/transactions', to: 'transactions_of_invoice#index'
        get '/:id/invoice_items', to: 'invoice_items_of_invoice#index'
        get '/:id/items', to: 'items_of_invoice#index'
        get '/:id/customer', to: 'customer_of_invoice#show'
        get '/:id/merchant', to: 'merchant_of_invoice#show'
        get '/random', to: 'random#show'
      end
      resources :invoices, only: [:index, :show]

      namespace :items do
        get '/find', to: 'search#show'
        get '/find_all', to: 'search#index'
        get 'most_revenue', to: 'revenue#index'
        get 'most_items', to: 'items#index'
        get '/:id/invoice_items', to: 'invoice_items_of_item#index'
        get '/:id/merchant', to: 'merchant_of_item#show'
        get '/random', to: 'random#show'
      end
      resources :items, only: [:index, :show]

      namespace :invoice_items do
        get '/find', to: 'search#show'
        get '/find_all', to: 'search#index'
        get '/:id/invoice', to: 'invoice_of_invoice_item#show'
        get '/:id/item', to: 'item_of_invoice_item#show'
        get '/random', to: 'random#show'
      end
      resources :invoice_items, only: [:index, :show]

      namespace :transactions do
        get '/find', to: 'search#show'
        get '/find_all', to: 'search#index'
        get '/:id/invoice', to: 'invoice_of_transaction#show'
        get '/random', to: 'random#show'
      end
      resources :transactions, only: [:index, :show]

    end

  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
