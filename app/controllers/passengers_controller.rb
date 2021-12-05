class PassengersController < ApplicationController
  def new
    @passenger=Passenger.new
  end


  def show
    @passenger=Passenger.new(passenger_params)
    if @passenger.save
      session[:passenger_id]= @passenger.id
      @ocode = TwilioClient.new.sendSMS(@passenger.phone)
      @otp = Otp.new(code: @ocode)
      @otp.save
      render :authenticate
      #redirect_to "/register/passengers/authenticate"
    else
      render :new
    end
  end


  def authenticate
    #@otp = Otp.new(code: params[:code])
    @otplast = Otp.last.code
    @otp = Otp.new(otp_params)
    if @otp.code == @otplast
      redirect_to "/rents"
    else
      render :authenticate
    end

    # if @otp.code == @ocode
    #   redirect_to "/rents"  
    # end
end

  private
  def passenger_params
      params.require(:passenger).permit(:email, :phone, :password, :password_confirmation)
  end

  private
    def otp_params
      params.require(:otp).permit(:code)
    end
end
