class MatchChannel < ApplicationCable::Channel

  @@matches = Hash.new

  def subscribed
    #if not in matches, add to it
    Thread.new do
      if !@@matches.key?(params[:match_id]) then
        @@matches[params[:match_id]] = Hash.new
        puts "30 Seconds Until Match Start"
        sleep 5 #change later
        @@matches[params[:match_id]]["active"] = true
        puts "Current Match #{@@matches[params[:match_id]]["active"]}"
      end
    end

    puts "Subscription for match #{params[:match_id]}"




    stream_from "match:#{params[:match_id]}"

  end

  def receive(data)
    puts "Received WPM: #{data["wpm"]}"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
