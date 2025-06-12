class Contact < ApplicationRecord
  belongs_to :proponent

  enum contact_type: {
    phone: 1,
    email: 2,
    whatsapp: 3
  }

  validates :contact_type, presence: true
  validates :value, presence: true
end
