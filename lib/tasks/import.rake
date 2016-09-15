require 'csv'
desc "Imports a CSV file into an ActiveRecord table"
task :import, [:filename] => :environment do    
    CSV.foreach('addresses.csv', :headers => true) do |row|
      Location.create!(row.to_hash)
    end
end