class ContractsController < ApplicationController
    
    def new
        @contract=Contract.new
    end

    def show
        valid_contract
        byebug
        session[:last_contract] = @contract.id
    end

    def create
        @contract = Contract.create(contract_params) do |c|
            c.owner_id = Location.find_by(id: session[:last_location]).owner.id
            c.consumer_id = session[:user_id]
            c.location_id = Location.find_by(id: session[:last_location]).id #session[:last_location]
            c.status = "Proposed"
        end
        redirect_to contract_path(@contract)
    end

    def consumer
        @contracts = Contract.where(consumer_id: session[:user_id])
    end

    def owner
        @contracts = Contract.where(owner_id: session[:user_id])
    end

    def update

        if params[:id].to_i == session[:last_contract]
            @contract = Contract.find_by(id: session[:last_contract])
            @contract.update(update_params)
            redirect_to contract_path(@contract)
        end

    end

    private

    def contract_params
        params.require(:contract).permit(:capacity, :term, :rate)
    end
    
    def update_params
        params.require(:contract).permit(:status)
    end

    def valid_contract
        byebug
        if !@contract=Contract.find_by(id: params[:id])
            redirect_to root_path
        end
        byebug
    end

end
