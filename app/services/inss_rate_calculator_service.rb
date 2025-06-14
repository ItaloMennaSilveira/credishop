class InssRateCalculatorService
  INSS_SALARY_RANGE_RATE = [
    { up_to: 1518.00, rate: 0.075, enum: :up_to_1518 },
    { up_to: 2793.88, rate: 0.09, enum: :from_1518_to_2793_88 },
    { up_to: 4190.83, rate: 0.12, enum: :from_2793_89_to_4190_83 },
    { up_to: 8157.41, rate: 0.14, enum: :from_4190_84_to_8157_41 }
  ].freeze

  def initialize(salary)
    @salary = salary
  end

  def calculate
    total = 0.0
    previous_value = 0.0
    salary_range_enum = nil

    INSS_SALARY_RANGE_RATE.each do |range|
      if @salary > range[:up_to]
        amount = range[:up_to] - previous_value
        total += amount * range[:rate]
        salary_range_enum = range[:enum]
        previous_value = range[:up_to]
      else
        amount = @salary - previous_value
        total += amount * range[:rate]
        salary_range_enum = range[:enum]
        break
      end
    end

    {
      rate: total.round(2),
      rate_type: salary_range_enum
    }
  end
end
