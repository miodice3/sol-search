class AssetsController < ApplicationController

    def new
        #@asset = Asset.new
    end

    def create
        byebug
    end

    private

    def asset_params
        params.require(:asset).permit(:name, :email, :password, :password_confirmation)
    end

end
