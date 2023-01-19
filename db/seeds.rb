# frozen_string_literal: true

require_relative 'seeds/support'

return if Rails.env.production?

# Please keep the order of the seeds, because Order depends on Shopper and Merchant
Seeds::ShopperSeeder.seed
Seeds::MerchantSeeder.seed
Seeds::OrderSeeder.seed
