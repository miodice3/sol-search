class ContractsController < ApplicationController

    def new
        @contract=Contract.new
        @location=Location.find_by(id: session[:last_location])
    end

    def show
        if valid_contract && authorized_contract
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
            c.location_id = Location.find_by(id: session[:last_location]).id
            c.status = "Proposed"
            end
        if @contract.valid?
            @user = @contract.owner
            @location = @contract.location
            UserMailer.with(user: @user, location: @location).contract_recieved_email.deliver_later
            redirect_to contract_path(@contract)
        else
            @location=Location.find_by(id: session[:last_location])
            render new_contract_path
        end       
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
            if @contract.valid?
                @owner = @contract.owner
                @consumer = @contract.consumer
                @location = @contract.location
                #this will also email both even if rejected
                UserMailer.with(owner: @owner, consumer: @consumer, location: @location, contract: @contract).contract_accepted_email_owner.deliver_later
                UserMailer.with(owner: @owner, consumer: @consumer, location: @location, contract: @contract).contract_accepted_email_consumer.deliver_later
                redirect_to contract_path(@contract)
            else
                @contract.status = "Proposed"
                render "contracts/show"
            end
        end
    end

    def index
        if params[:location_id]
          @contracts = Location.find(params[:location_id]).contracts
          @location = Location.find(params[:location_id])
        else
          flash[:error] = "You are not authorized to see this"
          redirect_to root_path
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