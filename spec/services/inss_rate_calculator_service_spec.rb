require 'rails_helper'

RSpec.describe InssRateCalculatorService, type: :service do
  describe "#calculate" do
    context "when salary is within the up_to_1518" do
      it "calculates correctly" do
        salary = 1400.00
        result = described_class.new(salary).calculate

        expect(result[:rate_type]).to eq(:up_to_1518)
        expect(result[:rate]).to eq((salary * 0.075).round(2))
      end
    end

    context "when salary is in the from_1518_to_2793_88" do
      it "calculates correctly" do
        salary = 2000.00
        result = described_class.new(salary).calculate

        expected = ((1518.00 * 0.075) + (2000.00 - 1518.00) * 0.09).round(2)

        expect(result[:rate_type]).to eq(:from_1518_to_2793_88)
        expect(result[:rate]).to eq(expected)
      end
    end

    context "when salary is in the from_2793_89_to_4190_83" do
      it "calculates correctly" do
        salary = 3500.00
        result = described_class.new(salary).calculate

        expected = (
          (1518.00 * 0.075) +
          (2793.88 - 1518.00) * 0.09 +
          (3500.00 - 2793.88) * 0.12
        ).round(2)

        expect(result[:rate_type]).to eq(:from_2793_89_to_4190_83)
        expect(result[:rate]).to eq(expected)
      end
    end

    context "when salary is in the from_4190_84_to_8157_41" do
      it "calculates correctly" do
        salary = 5000.00
        result = described_class.new(salary).calculate

        expected = (
          (1518.00 * 0.075) +
          (2793.88 - 1518.00) * 0.09 +
          (4190.83 - 2793.88) * 0.12 +
          (5000.00 - 4190.83) * 0.14
        ).round(2)

        expect(result[:rate_type]).to eq(:from_4190_84_to_8157_41)
        expect(result[:rate]).to eq(expected)
      end
    end

    context "when salary is at the top of the from_4190_84_to_8157_41" do
      it "calculates correctly" do
        salary = 8157.41
        result = described_class.new(salary).calculate

        expected = (
          (1518.00 * 0.075) +
          (2793.88 - 1518.00) * 0.09 +
          (4190.83 - 2793.88) * 0.12 +
          (8157.41 - 4190.83) * 0.14
        ).round(2)

        expect(result[:rate_type]).to eq(:from_4190_84_to_8157_41)
        expect(result[:rate]).to eq(expected)
      end
    end

    context "when salary exceeds the from_4190_84_to_8157_41" do
      it "calculates only up to the from_4190_84_to_8157_41 limit" do
        salary = 10000.00
        result = described_class.new(salary).calculate

        expected = (
          (1518.00 * 0.075) +
          (2793.88 - 1518.00) * 0.09 +
          (4190.83 - 2793.88) * 0.12 +
          (8157.41 - 4190.83) * 0.14
        ).round(2)

        expect(result[:rate_type]).to eq(:from_4190_84_to_8157_41)
        expect(result[:rate]).to eq(expected)
      end
    end
  end
end
