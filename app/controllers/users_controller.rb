class UsersController < ApplicationController

   def index

    render({ :template => "users/index.html.rb" })
   end
  end