require 'faker'
require 'cpf_cnpj'

class ProponentSeedJob < ApplicationJob
  queue_as :default

  def perform(quantity = 20)
    destroy_database_data
    create_admin_user

    quantity.times do |i|
      begin
        proponent = create_proponent

        rand(1..2).times do
          create_address(proponent)
        end

        rand(1..3).times do
          create_contact(proponent)
        end

        puts "Proponente ##{i + 1} criado com sucesso."

      rescue => e
        Rails.logger.error "Erro ao criar proponente ##{i + 1}: #{e.message}"
        puts "Erro ao criar proponente ##{i + 1}: #{e.message}"
        next
      end
    end

    puts "Seed Completa: Tentativa de criação de #{quantity} proponentes finalizada."
  end

  private

  def destroy_database_data
    Proponent.destroy_all
    Address.destroy_all
    Contact.destroy_all
    User.destroy_all
  end

  def create_admin_user
    User.create!(
      email: "admin_user@email.com",
      password: "admin_user",
      password_confirmation: "admin_user"
    )

    puts "Admin user criado com email: admin_user@email.com e senha: admin_user"
  end

  def create_proponent
    cpf = CPF.generate

    salary_value = Faker::Number.between(from: 1000.0, to: 10000.0).round(2)
    inss_result = InssRateCalculatorService.new(salary_value).calculate

    proponent = Proponent.create!(
      name: Faker::Name.name,
      document: cpf,
      salary: salary_value,
      inss_rate_type: inss_result[:rate_type],
      inss_rate: inss_result[:rate]
    )

    proponent
  end

  def create_address(proponent)
    zip_code = Faker::Number.number(digits: 8).to_s

    proponent.addresses.create!(
      street: Faker::Address.street_name,
      number: Faker::Address.building_number,
      complement: Faker::Address.secondary_address,
      zip_code: zip_code,
      city: Faker::Address.city,
      state: Faker::Address.state_abbr
    )
  end

  def create_contact(proponent)
    contact_type = Contact.contact_types.keys.sample
    value = case contact_type
            when 'phone', 'whatsapp'
              ddd = Faker::Number.between(from: 11, to: 99)
              number = "9#{Faker::Number.number(digits: 8)}"
              "#{ddd}#{number}"
            when 'email'
              Faker::Internet.email
            end

    proponent.contacts.create!(
      contact_type: contact_type,
      value: value
    )
  end
end
