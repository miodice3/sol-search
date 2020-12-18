class LocationsController < ApplicationController
    def new
        @location = Location.new
        #byebug
    end

    def create
        byebug
        @location = Location.create(location_params) do |l|
            l.owner_id = session[:user_id]
        end
        redirect_to location_path(@location)
    end

    def show
        #byebug
        @location = Location.find_by(id: params[:id])
    end

    def index
        @locations = Location.all
    end

    private

    def location_params
        params.require(:location).permit(:name, :utility, :zone, :meter_type, :state, :country, :annual_capacity, :status)
    end

end
