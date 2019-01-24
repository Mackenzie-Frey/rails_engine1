Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      namespace :transactions do
        resources :transactions, only: [:index, :show]
      end
    end
  end
  namespace :api do
    namespace :v1 do
      namespace :merchants do
        resources :merchants, only: [:index, :show]
      end
    end
  end
  namespace :api do
    namespace :v1 do
      namespace :items do
        resources :items, only: [:index, :show]
      end
    end
  end
  namespace :api do
    namespace :v1 do
      namespace :invoices do
        resources :invoices, only: [:index, :show]
      end
    end
  end
  namespace :api do
    namespace :v1 do
      namespace :invoice_items do
        resources :invoice_items, only: [:index, :show]
      end
    end
  end
  namespace :api do
    namespace :v1 do
      namespace :customers do
        resources :customers, only: [:index, :show]
      end
    end
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
