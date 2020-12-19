class ContractsController < ApplicationController
    
    def new
        @contract=Contract.new
    end

    def show
        @contract=Contract.first
    end

    def create
        # byebug
        @contract = Contract.create(contract_params) do |c|
            #byebug
            c.owner_id = Location.find_by(id: session[:last_location]).owner.id
            c.consumer_id = session[:user_id]
            c.asset_id = Location.find_by(id: session[:last_location]).id #session[:last_location]
            c.status = "Proposed"
        end
        redirect_to contract_path(@contract)
        #byebug
    end

    def consumer
        #byebug
        @contracts = Contract.find_by(consumer_id: session[:user_id])
        redirect_to contract_path (@contracts)
    end

    def owner
        #byebug
        @contracts = Contract.find_by(owner_id: session[:user_id])
        byebug #this evaluates to nil, and crashes redirect. should be directed to blank page with disclaimer, no owner contracts
        redirect_to contract_path (@contracts)
    end

    private

    def contract_params
        params.require(:contract).permit(:capacity, :term, :rate)
    end

end
