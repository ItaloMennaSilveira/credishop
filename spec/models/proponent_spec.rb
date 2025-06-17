require 'rails_helper'

RSpec.describe Proponent, type: :model do
  describe "associations" do
    it { should have_many(:addresses).dependent(:destroy) }
    it { should have_many(:contacts).dependent(:destroy) }
    it { should accept_nested_attributes_for(:addresses).allow_destroy(true) }
    it { should accept_nested_attributes_for(:contacts).allow_destroy(true) }
  end

  describe "enums" do
    it do
      should define_enum_for(:inss_rate_type).with_values(
        up_to_1518: 1,
        from_1518_to_2793_88: 2,
        from_2793_89_to_4190_83: 3,
        from_4190_84_to_8157_41: 4
      )
    end
  end

  describe "validations" do
    subject { build(:proponent) }

    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:document) }
    it { should validate_presence_of(:salary) }
    it { should validate_numericality_of(:salary) }
    it { should validate_numericality_of(:inss_rate).allow_nil }
  end

  describe "custom validations" do
    it "is invalid with an incorrect CPF" do
      proponent = build(:proponent, document: "123.456.789-00")
      expect(proponent).not_to be_valid
      expect(proponent.errors[:document]).to include("deve ser um CPF válido")
    end

    it "is valid with a correct CPF" do
      proponent = build(:proponent, document: CPF.generate)
      proponent.validate
      expect(proponent.errors[:document]).to be_empty
    end

    it "validates consistency of INSS data" do
      salary = 1600
      expected = InssRateCalculatorService.new(salary).calculate

      proponent = build(:proponent,
        salary: salary,
        inss_rate_type: expected[:rate_type],
        inss_rate: expected[:rate]
      )

      proponent.validate
      expect(proponent.errors[:inss_rate_type]).to be_empty
      expect(proponent.errors[:inss_rate]).to be_empty
    end

    it "adds errors when INSS data does not match" do
      proponent = build(:proponent,
        salary: 1600,
        inss_rate_type: :from_2793_89_to_4190_83,
        inss_rate: 99.99
      )

      proponent.validate
      expect(proponent.errors[:inss_rate_type]).not_to be_empty
      expect(proponent.errors[:inss_rate]).not_to be_empty
    end
  end
end
