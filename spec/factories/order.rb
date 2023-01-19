FactoryBot.define do
  factory :order do
    amount { Faker::Commerce.price }
    merchant
    shopper
  end
end
