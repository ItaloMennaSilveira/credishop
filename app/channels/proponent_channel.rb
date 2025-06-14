class ProponentChannel < ApplicationCable::Channel
  def subscribed
    proponent_id = params[:id]
    stream_from "proponent_#{proponent_id}"
  end
end
