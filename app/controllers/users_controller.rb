class UsersController < ApplicationController

   def index

    render({ :template => "users/index.html.rb" })
   end

   def results
   
    render({ :template => "users/results.html.rb" })
   end

  end