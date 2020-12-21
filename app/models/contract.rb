class Contract < ApplicationRecord
    
    belongs_to :owner, class_name: 'User'
    belongs_to :consumer, class_name: 'User'

    belongs_to :location

    scope :Proposed, -> { where(status: "Proposed") }
    scope :Accepted, -> { where(status: "Accepted") }
    scope :Declined, -> { where(status: "Declined") }

end
