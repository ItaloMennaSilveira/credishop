class InssRateCalculatorJob < ApplicationJob
  queue_as :default

  def perform(proponent_id, salary)
    result = InssRateCalculatorService.new(salary).calculate
    InssRateBroadcastService.new(proponent_id, result).broadcast
  end
end