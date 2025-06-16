class InssRateBroadcastService
  def initialize(token, result)
    @token = token
    @result = result
  end

  def broadcast
    InssRateChannel.broadcast_to(@token, {
      inss_rate: @result[:rate],
      inss_rate_type: @result[:rate_type]
    })
  end
end
