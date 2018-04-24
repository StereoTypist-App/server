class ProfileController < ApplicationController
    def profile
        if !params[:display_name] && current_user != nil then
            @user = current_user
            @results = @user.results.order(wpm: :desc).limit(25) if @user
        elsif params[:display_name] != nil then
            @user = User.find_by(display_name: params[:display_name])
            @results = @user.results.order(wpm: :desc).limit(25) if @user
        end
        
        if @user then
            @firstResult = @user.results.order(created_at: :asc).limit(1)[0]
            @lastResult = @user.results.order(created_at: :desc).limit(1)[0]
            @avgWPM = @user.results.average(:wpm)
            @bestWPM = @results[0].wpm
            @totalGames = @user.results.count
        end
    end
end
