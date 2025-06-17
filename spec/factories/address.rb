FactoryBot.define do
  factory :address do
    street { Faker::Address.street_name }
    number { Faker::Address.building_number }
    zip_code { '96010160' }
    city { Faker::Address.city }
    state { Faker::Address.state_abbr }
    association :proponent
  end
end
