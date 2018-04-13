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
    if data["start"] then
      @@matches[params[:match_id]]["active"] = true
      puts "Current Match Activated: #{@@matches[data["match_id"]]["active"]}"
      return
    end
    if @@matches[params[:match_id]]["active"] then
      puts "Received WPM: #{data["wpm"]}"
    else
      puts "Match not active, reject WPM."
    end
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
