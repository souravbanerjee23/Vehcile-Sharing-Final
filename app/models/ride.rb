class Ride < ApplicationRecord
    belongs_to :owner
    validates :vehicle_no,presence: true
    validates :seats,presence: true
    validates :start_point,presence: true
    validates :final_stop,presence: true
    validates :cost,presence: true
    validates :discount,presence: true
    validates :date,presence:true
    validate :validate_date
    
    def validate_date
        if date < Date.today
            errors.add(:date, "Date can't be in the past. Please choose today or a date in Future")
        end
    end
end
