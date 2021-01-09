class UsersController < ApplicationController
    before_action :require_login, except: [:create]

    def create
        @user = User.new(user_params)
        @user.confirmation_token = SecureRandom.hex(13)
            if @user.save
                session[:user_id] = @user.id
                UserMailer.with(user: @user).welcome_email.deliver_later
                redirect_to root_path
            else
                render 'sessions/signup'
            end
    end

    def show
        user_authorized
        find_user
    end

    def email_confirmation
        #byebug
        @user = User.find_by(confirmation_token: params[:token])
        @user.confirmed = true

        if @user.save
            flash[:error] = "Your email has been validated, thank you"
            redirect_to user_path(@user)
        else
            flash[:error] = "Email has not been validated."
            redirect_to root_path
        end
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