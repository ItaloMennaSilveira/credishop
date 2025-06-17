FactoryBot.define do
  factory :contact do
    contact_type { :email }
    value { Faker::Internet.email }
    association :proponent

    trait :phone do
      contact_type { :phone }
      value { '53999999999' }
    end

    trait :whatsapp do
      contact_type { :whatsapp }
      value { '53988888888' }
    end
  end
end
