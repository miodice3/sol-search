class SessionsController < ApplicationController
    #login, create, destroy, success for testing only, delete.     < change to this

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

    def login
        @user = User.new
    end

    def login_post
        @user = User.find_by(email: user_params[:email])
        if !!@user && @user.authenticate(user_params[:password])
            session[:user_id] = @user.id
            redirect_to success_path
        else
            redirect_to login_path
        end
    end

    def logout
        session.delete :user_id
        redirect_to success_path
    end

    private

    def auth
        request.env["omniauth.auth"]
    end

    def user_params
        params.require(:user).permit(:email, :password)
    end
end