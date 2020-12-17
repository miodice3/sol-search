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

    def login
    end

    def login_b
        @user = User.new
        # byebug
        @user = User.find_by(email: params[:email])
        if @user.authenticate(params[:password])
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
end


        #@user = User.new
        # byebug
        # @user = User.find_by(email: params[:email])
        # if @user.authenticate(params[:password])
        #     session[:user_id] = @user.id
        #     redirect_to success_path
        # else
        #    redirect_to login_path
        # end
