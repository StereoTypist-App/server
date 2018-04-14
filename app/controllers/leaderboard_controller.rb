class LeaderboardController < ApplicationController
    def leaderboard
        @leaderboard = Result.all.order(wpm: :desc).limit(50)
    end
end
