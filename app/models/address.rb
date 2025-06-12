class Address < ApplicationRecord
  belongs_to :proponent

  validates :street, :number, :zip_code, :city, :state, presence: true
end
