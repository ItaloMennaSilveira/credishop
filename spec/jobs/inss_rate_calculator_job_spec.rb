require 'rails_helper'

RSpec.describe InssRateCalculatorJob, type: :job do
  describe "#perform" do
    let(:token) { "abc123" }
    let(:salary) { 3000.00 }
    let(:calculated_result) { { rate: 250.0, rate_type: :from_2793_89_to_4190_83 } }

    it "calls the broadcast service with the correct result" do
      allow_any_instance_of(InssRateCalculatorService)
        .to receive(:calculate)
        .and_return(calculated_result)

      expect(InssRateBroadcastService).to receive(:new)
        .with(token, calculated_result)
        .and_return(double(broadcast: true))

      described_class.new.perform(token, salary)
    end
  end
end
