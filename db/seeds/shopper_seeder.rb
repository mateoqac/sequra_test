# frozen_string_literal: true
require 'csv'

module Seeds
  class ShopperSeeder
    class << self
      def seed
        path = 'lib/import/shoppers.csv'
        abort("Please place your CSV files in #{path} and run again.") unless File.exist?(path)

        to_insert = []
        CSV.foreach(path) do |row|
          params = {
            id: row[0],
            name: row[1],
            email: row[2],
            nif: row[3],
            created_at: Time.current,
            updated_at: Time.current
          }
          to_insert << params
        end
        Shopper.upsert_all(to_insert)
      end
    end
  end
end
