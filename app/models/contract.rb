class Contract < ApplicationRecord
    
    belongs_to :owner, class_name: 'User'
    belongs_to :consumer, class_name: 'User'

    belongs_to :location

end
