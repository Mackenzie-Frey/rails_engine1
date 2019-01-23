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

      # task all: :environment do
      #
      # end

    # end
