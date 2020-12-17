class User < ApplicationRecord
    has_secure_password

    validates :name, presence: true
    validates_uniqueness_of :email
    validates :password, length: { in: 2..20 }



    #validates :name

    #skip_before_action :verified_user, only: [:new, :create]

    def self.find_or_create_from_omniauth(access_token)
        User.find_or_create_by(email: access_token.info.email) do |u|
            u.name = access_token.info.first_name
            u.password = SecureRandom.hex(12)
        end
    end

    # def self.find_or_create_from_form(params)
    #     #byebug
    #     if params[:password] == params[:password_confirmation]
    #         User.find_or_create_by(email: params[:email]) do |u|
    #             u.name = params[:name]
    #             u.password = params[:password]
    #         end
    #     end
    # end

end
