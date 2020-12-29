class ContractsController < ApplicationController
    
    def new #no error handling
        @contract=Contract.new
    end

    def show #no error handling
        # byebug
        @contract = Contract.find_by(id: params[:id])
        session[:last_contract] = @contract.id
        # if valid_contract == true #&& authorized_contract == true
        #     session[:last_contract] = @contract.id
        # else
        #     flash[:error] = "You are not authorized to see this contract"
        #     redirect_to root_path
        # end
    end

    def create #error validations working
        @contract = Contract.create(contract_params) do |c|
            c.owner_id = Location.find_by(id: session[:last_location]).owner.id
            c.consumer_id = session[:user_id]
            c.location_id = Location.find_by(id: session[:last_location]).id #session[:last_location]
            c.status = "Proposed"
            end
        if @contract.valid?
            redirect_to contract_path(@contract)
        else
            render new_contract_path
        end       
        
        # @contract = Contract.create(contract_params) do |c|
        #     c.owner_id = Location.find_by(id: session[:last_location]).owner.id
        #     c.consumer_id = session[:user_id]
        #     c.location_id = Location.find_by(id: session[:last_location]).id #session[:last_location]
        #     c.status = "Proposed"
        # end
        # redirect_to contract_path(@contract)
    end

    def consumer #no error handling
        @contracts = Contract.where(consumer_id: session[:user_id]).order('contracts.updated_at DESC')
    end

    def owner #no error handling
        @contracts = Contract.where(owner_id: session[:user_id]).order('contracts.updated_at DESC')
    end

    def update
        # byebug
        if valid_contract && owner_contract && valid_origin
            @contract.update(update_params)
            if @contract.valid?
                redirect_to contract_path(@contract)
            else
                @contract.status = "Proposed"
                render "contracts/show"#contract_path(@contract) #'contracts/edit' #contract_path(@contract)
            end
        end
    end

    def index #no error handling
        # if owner, show additional information, or link to view individual contract
        if params[:location_id] #location's contracts, route ok
          @contracts = Location.find(params[:location_id]).contracts
          @location = Location.find(params[:location_id])
        else
          byebug #this needs to not be here, redirect unauthorized.
          @contracts = Contract.all
        #   flash[:error] = "You are not authorized to see this contract"
        #   redirect_to root_path
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
