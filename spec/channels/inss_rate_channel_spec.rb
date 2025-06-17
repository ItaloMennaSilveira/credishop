require 'rails_helper'

RSpec.describe InssRateChannel, type: :channel do
  let(:token) { "test_token_123" }

  before do
    subscribe(token: token)
  end

  it "successfully subscribes to the stream for the given token" do
    expect(subscription).to be_confirmed
    expect(subscription).to have_stream_from("inss_rate:#{token}")
  end
end
