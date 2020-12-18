class SolarArrayController < ApplicationController
    def new
        @SolarArray = SolarArray.new
    end

    def create
        byebug
    end
end
