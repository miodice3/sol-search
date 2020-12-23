class UsersController < ApplicationController
    #users/new & create, edit update destroy < add here.
    #helper method session[:user_id] = @user.id

    def create #creating new user
        @user = User.new(user_params)
            if @user.save
                session[:user_id] = @user.id
                redirect_to success_path
            else
                render 'sessions/signup'
            end
    end

    def show
        is_authorized

        find_user
    end

    private

    def user_params
        params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end

end