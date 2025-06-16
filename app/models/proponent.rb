class Proponent < ApplicationRecord
  has_many :addresses, dependent: :destroy
  has_many :contacts, dependent: :destroy

  accepts_nested_attributes_for :addresses, allow_destroy: true
  accepts_nested_attributes_for :contacts, allow_destroy: true

  enum :inss_rate_type, {
    up_to_1518: 1,
    from_1518_to_2793_88: 2,
    from_2793_89_to_4190_83: 3,
    from_4190_84_to_8157_41: 4
  }

  validates :name, presence: true
  validates :document, presence: true
  validates :salary, presence: true, numericality: true
  validates :inss_rate, numericality: true, allow_nil: true

  validate :cpf_must_be_valid
  validate :inss_data_must_be_consistent

  private

  def cpf_must_be_valid
    return if document.blank?

    unmasked_cpf = document.gsub(/\D/, "")
    unless CPF.valid?(unmasked_cpf)
      errors.add(:document, "deve ser um CPF válido")
    end
  end

  def inss_data_must_be_consistent
    return if salary.blank?

    result = InssRateCalculatorService.new(salary).calculate

    if inss_rate_type&.to_sym != result[:rate_type]
      errors.add(:inss_rate_type, "não condiz com o salário informado (esperado: #{result[:rate_type]})")
    end

    if inss_rate.to_f.round(2) != result[:rate]
      errors.add(:inss_rate, "não corresponde ao valor calculado (esperado: #{result[:rate]})")
    end
  end
end
