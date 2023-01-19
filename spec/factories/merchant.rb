FactoryBot.define do
  factory :merchant do
    name {Faker::Name.unique.name }
    email {Faker::Internet.unique.email}
    cif { Faker::Company.spanish_organisation_number}
  end
end
