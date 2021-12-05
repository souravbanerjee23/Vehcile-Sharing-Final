class OtpController < ApplicationController

    def new
        @otp = Otp.new
    end

    def authenticatep
        @passenger = Passengers.find(params[:id])
        @ocode = TwilioClient.new.sendSMS(@passengers.phone)
        @otp = Otp.new(otp_params)
        if @otp.save
            if @otp.code == @ocode
                redirect_to "/rents"
            end
        end
        #@ocode = 
    end

    def authenticateo

    end

    private
    def otp_params
      params.require(:otp).permit(:code)
    end
end
