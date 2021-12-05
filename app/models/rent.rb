class Rent < ApplicationRecord
  belongs_to :ride
  validates :start_location, presence: true
  validates :destination, presence: true
  validates :seats, presence: true
  validates :date, presence: true
  validate  :validate_date
  validate  :validate_location

  before_save :validations
#  before_update: validations

    def validations
      #@ride1 = Ride.where(id: ride.id)
      @ride2 = Ride.find(ride_id)
      correct = 1

      if start_location == @ride2.start_point
        if destination == @ride2.stop1 ||  destination == @ride2.stop2 ||  destination == @ride2.stop3 ||  destination == @ride2.stop4 ||    destination == @ride2.final_stop
          correct = 2
        end
      end

        if correct == 1 && start_location == @ride2.stop1
          if  destination == @ride2.stop2 ||  destination == @ride2.stop3 ||  destination == @ride2.stop4 ||  destination == @ride2.final_stop
            correct = 2
          
          # else
          #   errors.add(:start_location, "Please choose appropriate starting point and destination")
           end
        end

        if correct == 1 && start_location == @ride2.stop2
          if destination == @ride2.stop3 ||  destination == @ride2.stop4  ||  destination == @ride2.final_stop
            correct = 2
          # else
          #   errors.add(:start_location, "Please choose appropriate starting point and destination")
           end
        end
        if correct == 1 && start_location == @ride2.stop3
          if  destination == @ride2.stop4  ||  destination == @ride2.final_stop
            correct = 2
          # else
          #   errors.add(:start_location, "Please choose appropriate starting point and destination")
           end
        end

        if correct == 1 && start_location == @ride2.stop4
          if destination == @ride2.final_stop
            correct = 2
          # else
          #   errors.add(:start_location, "Please choose appropriate starting point and destination")
           end
        end

         if correct == 1 
           errors.add(:start_location, "Please choose appropriate starting point and destination")
         end

         if date != @ride2.date
          errors.add(:date, "Please choose proper journey date")
         end
    end


    def validate_location
      if start_location == destination
        errors.add(:start_location, "and destination cannot be same...!!!")
      end
    end

    def validate_date
        if date < Date.today
            errors.add(:date, "can't be in the past. Please choose today or a date in Future")
        end
        validations
    end
end

