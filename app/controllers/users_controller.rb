class UsersController < ApplicationController
    before_action :require_login, except: [:create]

    def create
        @user = User.new(user_params)
            if @user.save
                UserMailer.with(user: @user).welcome_email.deliver_now
                byebug
                session[:user_id] = @user.id
                redirect_to root_path
            else
                render 'sessions/signup'
            end
    end

    def show
        user_authorized
        find_user
    end

    private

    def user_params
        params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end

    def user_authorized
        if params[:id].to_i != session[:user_id]
            flash[:error] = "You are not authorized to access this profile"
            redirect_to root_path
        end
    end

end