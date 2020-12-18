class ContractsController < ApplicationController
    
    def new
        @contract=Contract.new
    end

    def create
        byebug
    end
end
