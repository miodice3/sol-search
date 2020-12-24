class ContractsController < ApplicationController
    
    def new
        @contract=Contract.new
    end

    def show
        if valid_contract == true && authorized_contract == true
            session[:last_contract] = @contract.id
        else
            flash[:error] = "You are not authorized to see this contract"
            redirect_to root_path
        end
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
        @contracts = Contract.where(consumer_id: session[:user_id]).order('contracts.updated_at DESC')
    end

    def owner
        @contracts = Contract.where(owner_id: session[:user_id]).order('contracts.updated_at DESC')
    end

    def update
        if valid_contract && owner_contract && valid_origin
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
        if !@contract=Contract.find_by(id: params[:id]) 
            false
        else
            true
        end
    end

    def authorized_contract
        @contract.owner_id == session[:user_id] || @contract.consumer_id == session[:user_id]
    end

    def owner_contract
        @contract.owner_id == session[:user_id]
    end

    def valid_origin
        params[:id].to_i == session[:last_contract]
    end

end
