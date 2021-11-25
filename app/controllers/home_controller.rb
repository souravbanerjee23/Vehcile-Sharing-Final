class HomeController < ApplicationController
    def index
        if session[:passenger_id]
            @passenger=Passenger.find_by(id: session[:passenger_id])
        end
    end
end
