class UsersController < ApplicationController
    def new
        #new comment
        @user = User.new
    end
end
