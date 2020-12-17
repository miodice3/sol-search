class UsersController < ApplicationController
    def new
        #new comment
        @user = User.new
    end

    def create
        byebug
    end
    
end
