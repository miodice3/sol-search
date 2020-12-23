class Location < ApplicationRecord

    belongs_to :owner, class_name: 'User'
    has_many :contracts

    validates :name, :owner_id, :utility, :zone, :meter_type, :state, :country, :annual_capacity, :status, presence: true
    validates :state, length: { is: 2 }

    #validates :name, :email, :password, presence: true
    #validates_uniqueness_of :email
    #validates :password, length: { in: 6..20 }

    #fayette=Location.last
    #fayette.owner= this returns entire user instance, working well.
    
end
