class SessionsController < ApplicationController
    
    def signup
        @user = User.new
    end

    def success
    end

    def googleAuth
        @user = User.find_or_create_from_omniauth(auth)
        session[:user_id] = @user.id
        redirect_to success_path
    end

    def create
        byebug
    end


    def logout
        session.delete :user_id
        redirect_to success_path
    end

    private

    def auth
        request.env["omniauth.auth"]
    end
end
