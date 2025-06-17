require 'rails_helper'

RSpec.describe InssRateBroadcastService do
  let(:token) { "some_token" }
  let(:result) { { rate: 123.45, rate_type: :from_1518_to_2793_88 } }

  it "broadcasts the INSS rate data to the correct token" do
    expect(InssRateChannel).to receive(:broadcast_to).with(token, {
      inss_rate: result[:rate],
      inss_rate_type: result[:rate_type]
    })

    service = described_class.new(token, result)
    service.broadcast
  end
end
