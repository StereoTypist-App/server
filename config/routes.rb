Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  get "/leaderboard", to: "leaderboard#leaderboard"
  get "/profile", to: "profile#profile"
  get "/profile/:display_name", to: "profile#profile"
  root to: "static_page#index"
end
