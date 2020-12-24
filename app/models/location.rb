class Location < ApplicationRecord

    belongs_to :owner, class_name: 'User'
    has_many :contracts

    validates :name, :owner_id, :utility, :zone, :meter_type, :state, :country, :annual_capacity, :status, presence: true
    validates :annual_capacity, numericality: { only_integer: true }
    validates :state, length: { is: 2 }

end
