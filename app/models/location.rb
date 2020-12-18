class Location < ApplicationRecord

    belongs_to :owner, class_name: 'User'

    #validates :name, :email, :password, presence: true
    #validates_uniqueness_of :email
    #validates :password, length: { in: 6..20 }

    has_many :contracts
    #fayette=Location.last
    #fayette.owner= this returns entire user instance, working well.
end
