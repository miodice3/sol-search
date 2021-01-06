class SessionsController < ApplicationController

    def signup
        @user = User.new
    end

    def googleAuth
        @user = User.find_or_create_from_omniauth(auth)
        session[:user_id] = @user.id
        redirect_to root_path
    end

    def login
        @user = User.new
    end

    def login_post #rendered error message if user or password not found
        @user = User.find_by(email: user_params[:email])
        if !!@user && @user.authenticate(user_params[:password])
            UserMailer.with(user: @user).welcome_email.deliver_now
            session[:user_id] = @user.id
            redirect_to root_path
        else
            flash[:error] = "Email or Password not validated, please try again"
            redirect_to login_path
            #render causes omission of params hash and fails strong params
        end
    end

    def logout
        session.delete :user_id
        redirect_to root_path
    end

    private

    def auth
        request.env["omniauth.auth"]
    end

    def user_params
        params.require(:user).permit(:email, :password)
    end
end