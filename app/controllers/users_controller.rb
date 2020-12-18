class UsersController < ApplicationController

    #helper method session[:user_id] = @user.id

    def create #creating new user
        if user_params[:password] == user_params[:password_confirmation]
            @user = User.create(user_params)
            #byebug
            if @user.id
                session[:user_id] = @user.id
                redirect_to success_path
            else
                redirect_to login_path
            end
        else
            redirect_to login_path
        end
    end

    def show
        @user = User.find_by(id: session[:user_id])
    end

    private

    def user_params
        params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end

end
