class Feedback < ApplicationRecord
    belongs_to :user
    validates :feedback, :name, length: { in: 1..1000 }
end
