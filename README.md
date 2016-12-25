Things to get done:

-Make models for user, games (will hold tags), events/scores
    -Have a basic page for each user (just show their name) and use this to test sessions and authentications

-Make an additional password on the player signup so I can control who goes in?

-For the models, have their forms (create, edit, delete) and display pages made
    -start with a player page
    
-Fix up results display data and have the 

-An "about" page for showing how this works (leave this for the end?)


MAKING IT SO WE DON'T CHECK LOGIN BEFORE EVERYTHING

class PostsController < ApplicationController
  skip_before_action :login_required, :only => [:index]


Important commands

-starting local database

sudo service postgresql start
psql -c "create database scoreViewer_test owner=ubuntu"
rake db:migrate
psql -c "create database scoreViewer_development owner=ubuntu"
rake db:migrate RAILS_ENV=test
rake test:models


-Making new things

rails genereate resource <name> <var1>:<var1type> etc

-running it
rails server -b $IP -p $PORT

USERS:
Name string
password string
