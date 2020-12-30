class User < ApplicationRecord
    has_secure_password

    validates :name, :email, presence: true
    validates_uniqueness_of :email

    validates :password, :presence =>true, :confirmation =>true
    validates_confirmation_of :password, :message => "Passwords should match"
    
    validates :password, length: { in: 6..50 }

    has_many :feedbacks

    has_many :owner_contracts, foreign_key: :owner_id, class_name: 'Contract'
    has_many :consumer_contracts, foreign_key: :consumer_id, class_name: 'Contract'

    has_many :owned_assets, foreign_key: :owner_id, class_name: 'Location'

    def self.find_or_create_from_omniauth(access_token)
        User.find_or_create_by(email: access_token.info.email) do |u|
            u.name = access_token.info.first_name
            u.password = SecureRandom.hex(12)
        end
    end

end
