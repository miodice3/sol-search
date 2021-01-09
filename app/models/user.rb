class User < ApplicationRecord
    has_secure_password

    validates :name, :email, presence: true
    validates_uniqueness_of :email

    # validates :password, :presence =>true, :confirmation =>true #works but breaks email validation
    # validates :password, :presence =>true, :confirmation =>true, :on => :create #works w email but not good for pw update or reset
    validates :password, :presence =>true, :confirmation =>true, :if => :password
    validates_confirmation_of :password, :message => "Passwords should match"
    
    # validates :password, length: { in: 6..50 } #works but breaks email validation
    # validates :password, length: { in: 6..50 }, :on => :create #works w email but not good for pw update or reset
    validates :password, length: { in: 6..50 }, :if => :password
    # validates :password, length: { in: 6..50 }, :if => :password #did not work
    # validates :password, length: { in: 6..50 }, allow_nil: true #did not work

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
