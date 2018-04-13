class MatchChannel < ApplicationCable::Channel

  @@matches = Hash.new

  def subscribed
    #if not in matches, add to it
    if !@@matches.key?(params[:match_id]) then
      @@matches[params[:match_id]] = Hash.new
    end

    puts "Subscription for match #{params[:match_id]}" 

    stream_from "match:#{params[:match_id]}"

  end

  def receive(data)
    puts "Received WPM: #{data["wpm"]} id #{connection_identifier}"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
