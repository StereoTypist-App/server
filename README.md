# CS252 Project 6 Backend Server

## Team Members
* Andrew Arpasi
* Vishnu Vijayan
* Aung Myat

## What is it?
This is a type racing application. Users will see who can have the fastest WPM in a set amount of time. It features a database for storing user info and typing results, live typing matches over the Internet, user profiles and leaderboards.

## Technology
This is the backend server that hosts and communicates with the client application. The client repository can also be found within our organization.

The backend is built with Ruby on Rails using the ActionCable real time communication feature and a SQL based database (when deployed, will be hosted using mySQL. Currently uses SQLite). It uses the Devise open source library for user authentication.

## Setting Up Server Locally
1. Install rvm, Ruby Version Manager, and get Ruby 2.4.1 and Rails 5.2.0
2. Once done, run `bundle install`
3. Open `config/initializers/devise.rb` and uncomment the token line, or change the token
4. Run `rails db:migrate` to set up the database
5. Run `rails server` and head to https://stereotypist.herokuapp.com on your browser!
