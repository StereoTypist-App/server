require 'securerandom'

class MatchChannel < ApplicationCable::Channel

  @@matches = Hash.new

  MATCH_DURATION = 15
  DELTA = 0.5

  def subscribed
    #if not in matches, add to it
    if !@@matches.key?(params[:match_id]) then
      @@matches[params[:match_id]] = Hash.new
    end

    #don't allow users to join active matches once started
    if @@matches[params[:match_id]]["active"] == true then
      reject
      return
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
      texts = load_text(1)
      ActionCable.server.broadcast "match:#{params[:match_id]}", {started: true, texts: texts}
      Thread.new do
        sleep MATCH_DURATION + DELTA #change later
        @@matches[params[:match_id]].delete("active")
        puts "Match Over #{@@matches[params[:match_id]]}"
        ActionCable.server.broadcast "match:#{params[:match_id]}", {complete: true, result: @@matches[params[:match_id]]}
      end
      return
    end
    
    if @@matches[params[:match_id]]["active"] then
      @@matches[params[:match_id]][@user_display_name] = data["wpm"]
      puts "Received WPM: #{data["wpm"]} from #{@user_display_name}"
      ActionCable.server.broadcast "match:#{params[:match_id]}", {complete: false, result: @@matches[params[:match_id]]}
    end
  end

  def unsubscribed
    if current_user != nil then
      result = Result.new
      result.wpm = @@matches[params[:match_id]][@user_display_name]
      result.user = current_user
      result.save
    end
    
    @@matches[params[:match_id]].delete(@user_display_name)
  end

  def load_text(index)
    text_json_file = File.join(Rails.root, "app", "assets", "texts", "#{index}.json")
    text_json = File.read(text_json_file)
    texts = JSON.parse(text_json)
    return texts
  end
end
