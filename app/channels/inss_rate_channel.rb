class InssRateChannel < ApplicationCable::Channel
  def subscribed
    stream_for params[:token]
  end
end