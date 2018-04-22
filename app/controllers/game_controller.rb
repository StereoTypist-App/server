class GameController < ApplicationController
    def home
        @user = current_user
        render :layout => false
    end

    def game
        @user = current_user
        render :layout => false
    end
end
