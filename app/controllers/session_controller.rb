class SessionController < ApplicationController
    def new
    end
    def create
        passenger=Passenger.find_by(email: params[:email])
        if passenger.present? &&passenger.authenticate(params[:password])
            session[:passenger_id]=passenger.id
            redirect_to root_path, notice: "Log in Successfully"
        else
            flash[:alert]="Invalid credentials"
            render :new
        end
    end
    def destroy
        session[:paassenger_id] = nil
        redirect_to root_path, notice: "Logged Out"
    end
end
