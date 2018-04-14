class LeaderboardController < ApplicationController
    def leaderboard
        @top_results = Result.all.order(wpm: :desc).limit(50)
    end
end
