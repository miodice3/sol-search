class LocationsController < ApplicationController

    def mylocations #no error handling
        @user = User.find_by(id: session[:user_id])
        @locations = @user.owned_assets
    end

    def new #no error handling
        @location = Location.new
    end

    def create #error handling working
        @location = Location.create(location_params) do |l|
            l.owner_id = session[:user_id]
        end
        #byebug
        if @location.save
            redirect_to location_path(@location)
        else
            render "locations/new"
        end
    end

    def show #no error handling
        @location = Location.find_by(id: params[:id])
        session[:last_location] = @location.id
    end

    def edit #no error handling
        edit_authorized
        session[:last_location] = @location.id
    end

    def update #error handling working
        edit_authorized
        if @location.update(location_params)
            redirect_to location_path(@location)
        else
            render "locations/edit"
        end
    end

    def index #no error handling
        @locations = Location.all
    end

    private

    def location_params
        params.require(:location).permit(:name, :utility, :zone, :meter_type, :state, :country, :annual_capacity, :status)
    end

    def edit_authorized
        if @location = Location.find_by(id: params[:id])
            if @location.id != session[:last_location]
                flash[:error] = "You are not authorized to edit this location"
                redirect_to root_path
            end
        else
            flash[:error] = "You are not authorized to edit this location"
            redirect_to root_path
        end
    end

end
