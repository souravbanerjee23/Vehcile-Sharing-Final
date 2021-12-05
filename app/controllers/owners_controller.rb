class OwnersController < ApplicationController

    def new
      @owner=Owner.new
    end
    
    def show
      @owner=Owner.new(owner_params)
      if @owner.save
        session[:owner_id]=@owner.id
        @ocode = TwilioClient.new.sendSMS(@owner.phone)
        @otp = Otp.new(code: @ocode)
        @otp.save
        render :authenticate
        #redirect_to rides_path, notice: "Suceessfully Created Account"
      else
        render :new
      end
    end

    def authenticate
      #@otp = Otp.new(code: params[:code])
      @otplast = Otp.last.code
      @otp = Otp.new(otp_params)
      if @otp.code == @otplast
        redirect_to "/rides"
      else
        render :authenticate
      end
      
      # if @otp.code == @ocode
      #   redirect_to "/rents"  
      # end
  end

    private
    def owner_params
        params.require(:owner).permit(:name, :email, :phone, :password, :password_confirmation)
    end

    def otp_params
      params.require(:otp).permit(:code)
    end
end
  