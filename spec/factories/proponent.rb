FactoryBot.define do
  factory :proponent do
    name { Faker::Name.name }
    document { CPF.generate }
    salary { rand(1000.0..9000.0).round(2) }

    transient do
      calculated { InssRateCalculatorService.new(salary).calculate }
    end

    inss_rate_type { calculated[:rate_type] }
    inss_rate { calculated[:rate] }

    after(:build) do |proponent|
      proponent.addresses << build(:address, proponent: proponent)
      proponent.contacts << build(:contact, proponent: proponent)
    end
  end
end
