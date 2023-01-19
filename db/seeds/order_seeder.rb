# frozen_string_literal: true

require 'csv'

module Seeds
  class OrderSeeder
    class << self
      def seed
        path = 'lib/import/orders.csv'
        abort("Please place your CSV files in #{path} and run again.") unless File.exist?(path)

        to_insert = []
        CSV.foreach(path) do |row|
          params = {
            id: row[0],
            merchant_id: row[1],
            shopper_id: row[2],
            amount: row[3],
            created_at: row[4],
            completed_at: row[5] || nil,
            updated_at: Time.current
          }
          to_insert << params
        end
        Order.upsert_all(to_insert)
      end
    end
  end
end
