class GameController < ApplicationController
    def game
        @user = current_user
        render :layout => false
    end
end
