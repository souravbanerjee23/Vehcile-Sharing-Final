class Vehicle < ApplicationRecord
    validates :vehicle_no,presence: true
    validates :seats,presence: true
    validates :start_point,presence: true
    validates :final_stop,presence: true
    validates :cost,presence: true
    validates :discount,presence: true
end
