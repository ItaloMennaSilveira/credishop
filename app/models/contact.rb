class Contact < ApplicationRecord
  belongs_to :proponent

  enum :type, {
    phone: 1,
    email: 2,
    whatsapp: 3
  }

  validates :type, presence: true
  validates :value, presence: true
end
