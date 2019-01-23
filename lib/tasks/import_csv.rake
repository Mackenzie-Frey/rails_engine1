require 'csv'

namespace :import do
  desc 'Imports data from CSV files'

      task :customers => :environment do
        CSV.foreach('./db/csv/customers.csv', :headers => true) do |row|
          Customer.create!(row.to_h)
        end
      end
end

namespace :import do
  desc 'Imports data from CSV files'
      task :merchants => :environment do
        CSV.foreach('./db/csv/merchants.csv', :headers => true) do |row|
          Merchant.create!(row.to_h)
        end
      end
    end

      # task all: :environment do
      #
      # end

    # end
