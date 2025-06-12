class Proponent < ApplicationRecord
  has_many :addresses, dependent: :destroy
  has_many :contacts, dependent: :destroy

  enum inss_rate_type: {
    up_to_1518: 1,
    from_1518_to_2793_88: 2,
    from_2793_89_to_4190_83: 3,
    from_4190_84_to_8157_41: 4
  }

  validates :name, :document, :salary, presence: true
  validates :inss_rate_type, numericality: { only_integer: true }, allow_nil: true
  validates :inss_rate, numericality: true, allow_nil: true
end
