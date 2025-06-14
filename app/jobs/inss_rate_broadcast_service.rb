class InssRateBroadcastService
  def initialize(proponent_id, result)
    @proponent_id = proponent_id
    @result = result
  end

  def broadcast
    Turbo::StreamsChannel.broadcast_replace_to(
      "proponent_#{@proponent_id}",
      target: "inss-dynamic-target",
      partial: "proponents/inss_result",
      locals: {
        rate: @result[:rate],
        rate_type: @result[:rate_type]
      }
    )
  end
end
