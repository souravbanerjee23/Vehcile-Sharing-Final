class PassengersController < ApplicationController
  def new
    @passenger=Passenger.new
  end
  def show
    @passenger=Passenger.new(passenger_params)
    if @passenger.save
      session[:passenger_id]=@passenger.id
      redirect_to root_path, notice: "Suceessfully Created Account"
    else
      render :new
    end
  end
  private
  def passenger_params
      params.require(:passenger).permit(:email, :phone, :password, :password_confirmation)
  end
end
