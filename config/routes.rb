Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      namespace :customers do
        get '/find', to: 'search#show'
        get '/find_all', to: 'search#index'
      end
      resources :customers, only: [:index, :show]

      namespace :merchants do
        get '/find', to: 'search#show'
        get '/find_all', to: 'search#index'
      end
      resources :merchants, only: [:index, :show]

      namespace :invoices do
        get '/find', to: 'search#show'
      end
      resources :invoices, only: [:index, :show]

  #       resources :transactions, only: [:index, :show]
  #       resources :items, only: [:index, :show]
  #       resources :invoice_items, only: [:index, :show]
    end
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
