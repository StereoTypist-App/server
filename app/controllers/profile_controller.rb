class ProfileController < ApplicationController
    def profile
        if !params[:display_name] && current_user != nil then
            @user = current_user
            @results = @user.results.order(wpm: :desc) if @user
        elsif params[:display_name] != nil then
            @user = User.find_by(display_name: params[:display_name])
            @results = @user.results.order(wpm: :desc) if @user
        end

    end
end
