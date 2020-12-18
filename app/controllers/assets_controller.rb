class AssetsController < ApplicationController

    def create
        byebug
    end

    def new
        @asset = Asset.new
        #byebug
        #ADD NAME FIELD TO ASSET ALSO
        # <%= f.label :class_number %> <<< ADD TO FORMS ONCE MIGRATION ISSUE FIXED
        # <%= f.text_field :class_number %><br>
    end

    def show
        @asset = Asset.find_by(id: params[:id])
    end

    def index
        @assets = Asset.all
    end

    private

    def asset_params
        params.require(:asset).permit(:name, :email, :password, :password_confirmation)
    end

end
