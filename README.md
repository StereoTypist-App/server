# CS252 Project 6 Backend Server

## Team Members
* Andrew Arpasi
* Vishnu Vijayan
* Aung Myat

## Live Version
Current state of the application, deployed to heroku:
https://stereotypist.herokuapp.com/

## What is it?
This is a type racing application. Users will see who can have the fastest WPM in a set amount of time. It features a database for storing user info and typing results, live typing matches over the Internet, user profiles and leaderboards.

## Technology
This is the backend server that hosts and communicates with the client application. The client repository can also be found within our organization.

The backend is built with Ruby on Rails using the ActionCable real time communication feature. For database, it uses PostgreSQL, which Rails ActiveRecord utilizes to form relational models from application data. It uses the Devise open source library for user authentication.

## Setting Up Server Locally
0. Install rvm, Ruby Version Manager, and get Ruby 2.4.1 and Rails 5.2.0
1. Install Postgres and setup a database named `stereotypist`
2. Once done, run `bundle install`
3. Open `config/initializers/devise.rb` and uncomment the token line, or change the token
4. Run `rails db:migrate` to set up the database
5. Run `rails server` and head to hlocalhost on your browser!
