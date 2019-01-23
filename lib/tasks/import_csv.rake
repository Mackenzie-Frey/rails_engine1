require 'csv'

namespace :import do
  desc 'Imports customer data from CSV file'
      task :customers => :environment do
        CSV.foreach('./db/csv/customers.csv', :headers => true) do |row|
          Customer.create!(row.to_h)
        end
      end
end

namespace :import do
  desc 'Imports merchant data from CSV file'
      task :merchants => :environment do
        CSV.foreach('./db/csv/merchants.csv', :headers => true) do |row|
          Merchant.create!(row.to_h)
        end
      end
end

namespace :import do
  desc 'Imports item data from CSV file'
      task :items => :environment do
        CSV.foreach('./db/csv/items.csv', :headers => true) do |row|
          Item.create!(row.to_h)
        end
      end
end

namespace :import do
  desc 'Imports invoice data from CSV file'
      task :invoices => :environment do
        CSV.foreach('./db/csv/invoices.csv', :headers => true) do |row|
          Invoice.create!(row.to_h)
        end
      end
end

namespace :import do
  desc 'Imports invoice_item data from CSV file'
      task :invoice_items => :environment do
        CSV.foreach('./db/csv/invoice_items.csv', :headers => true) do |row|
          InvoiceItem.create!(row.to_h)
        end
      end
end

namespace :import do
  desc 'Imports transaction data from CSV file'
      task :transactions => :environment do
        CSV.foreach('./db/csv/transactions.csv', :headers => true) do |row|
          Transaction.create!(row.to_h)
        end
      end
end
