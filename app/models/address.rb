class Address < ApplicationRecord
  belongs_to :proponent

  validates :street, :number, :zip_code, :city, :state, presence: true
  validates :zip_code, format: {
    with: /\A\d{8}\z/,
    message: "deve conter exatamente 8 dígitos, sem hífen"
  }
end
