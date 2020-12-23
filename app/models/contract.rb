class Contract < ApplicationRecord
    
    belongs_to :owner, class_name: 'User'
    belongs_to :consumer, class_name: 'User'

    belongs_to :location

    scope :Proposed, -> { where(status: "Proposed") }
    scope :Accepted, -> { where(status: "Accepted") }
    scope :Declined, -> { where(status: "Declined") }
    #scope method for kWh* term of contract for total kWh fascilitated

    def end_date(c)
        finish = c.created_at + (c.term*365).day
    end


end
