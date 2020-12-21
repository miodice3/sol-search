class LocationsController < ApplicationController

    def mylocations
        @user = User.find_by(id: session[:user_id])
        @locations = @user.owned_assets
    end
    
    def new
        @location = Location.new
    end

    def create
        @location = Location.create(location_params) do |l|
            l.owner_id = session[:user_id]
        end
        # need to do error handling and re-direct user back to form if they fill out and it fails
        redirect_to location_path(@location)
    end

    def show
        @location = Location.find_by(id: params[:id])
        session[:last_location] = @location.id
    end

    def index
        @locations = Location.all
    end

    # def update
    #     byebug
    # end

    private

    def location_params
        params.require(:location).permit(:name, :utility, :zone, :meter_type, :state, :country, :annual_capacity, :status)
    end

end
