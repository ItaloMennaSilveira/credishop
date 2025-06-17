class InssRateCalculatorJob < ApplicationJob
  queue_as :default

  def perform(token, salary)
    result = InssRateCalculatorService.new(salary).calculate
    InssRateBroadcastService.new(token, result).broadcast
  end
end
