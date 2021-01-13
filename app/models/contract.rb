class Contract < ApplicationRecord
    
    belongs_to :owner, class_name: 'User'
    belongs_to :consumer, class_name: 'User'

    belongs_to :location

    validates :owner_id, :consumer_id, :location_id, :capacity, :term, :rate, presence: true
    validates :owner_id, :consumer_id, :location_id, :capacity, :term, :rate, numericality: { only_integer: true }
    validates :status, length: { is: 8 }
    validates :status,
                    inclusion: {
                        in: [
                        'Proposed',
                        'Accepted',
                        'Declined'
                        ],
                        message: "Please select Accepted or Declined"
                    }

    #scope method for kWh* term of contract for total kWh fascilitated                    
    scope :Proposed, -> { where(status: "Proposed") }
    scope :Accepted, -> { where(status: "Accepted") }
    scope :Declined, -> { where(status: "Declined") }
#remove capitals, not standard naming convention

    def end_date(c)
        finish = c.created_at + (c.term*365).day
    end


end
