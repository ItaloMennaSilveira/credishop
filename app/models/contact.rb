class Contact < ApplicationRecord
  belongs_to :proponent

  enum :contact_type, {
    phone: 1,
    email: 2,
    whatsapp: 3
  }

  validates :contact_type, presence: true
  validates :value, presence: true
  validate :validate_value_format

  before_validation :normalize_phone_number

  private

  def phone_or_whatsapp?
    contact_type.in? %w[phone whatsapp]
  end

  def normalize_phone_number
    return unless phone_or_whatsapp?
    return if value.blank?

    digits = value.gsub(/\D/, '')
    self.value = digits[0, 14]
  end

  def validate_value_format
    return if phone_or_whatsapp?

    if contact_type == "email"
      unless value =~ URI::MailTo::EMAIL_REGEXP
        errors.add(:value, "deve ser um endereço de email válido")
      end
    else
      errors.add(:contact_type, "é inválido")
    end
  end
end
