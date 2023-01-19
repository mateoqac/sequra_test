FactoryBot.define do
  factory :disbursement do
    merchant
    amount {  rand(0..100) }
    disbursed_at { "2023-01-19" }
  end
end
