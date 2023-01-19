# frozen_string_literal: true

require 'csv'

module Seeds
  class MerchantSeeder
    class << self
      def seed
        path = 'lib/import/merchants.csv'
        abort("Please place your CSV files in #{path} and run again.") unless File.exist?(path)

        to_insert = []
        CSV.foreach(path) do |row|
          params = {
            id: row[0],
            name: row[1],
            email: row[2],
            cif: row[3],
            created_at: Time.current,
            updated_at: Time.current
          }
          to_insert << params
        end
        Merchant.upsert_all(to_insert)
      end
    end
  end
end
