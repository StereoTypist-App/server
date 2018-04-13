require 'securerandom'

class MatchChannel < ApplicationCable::Channel

  @@matches = Hash.new

  def subscribed
    #if not in matches, add to it
    if !@@matches.key?(params[:match_id]) then
      @@matches[params[:match_id]] = Hash.new
    end

    @user_display_name =  "Anon#{SecureRandom.hex[0..6]}"
    if current_user != nil then
      @user_display_name = current_user.display_name
    end

    puts "Subscription for match #{params[:match_id]} user: #{@user_display_name}"

    stream_from "match:#{params[:match_id]}"

  end

  def receive(data)
    if data["start"] then
      if @@matches[params[:match_id]]["active"] == true then
        return
      end
      @@matches[params[:match_id]]["active"] = true
      puts "Current Match Activated: #{@@matches[params[:match_id]]["active"]}"
      Thread.new do
        sleep 15 #change later
        @@matches[params[:match_id]]["active"] = false
        puts "Match Over #{@@matches[params[:match_id]]}"
        ActionCable.server.broadcast "match:#{params[:match_id]}", {complete: true, result: @@matches[params[:match_id]]}
      end
      return
    end
    if @@matches[params[:match_id]]["active"] then
      puts "Received WPM: #{data["wpm"]} from #{@user_display_name}"
    end
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
