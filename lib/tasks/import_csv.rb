require 'csv'

# namespace :import do
  desc 'Imports data from CSV files'
      task customers: :environment do
        CSV.foreach('db/customers.csv', :headers => true) do |row|
          Customers.create!(row.to_hash)
        end
      end
# end
