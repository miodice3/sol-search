class Feedback < ApplicationRecord
    belongs_to :user
    validates :feedback, :name, length: { in: 0..1000 }
end
