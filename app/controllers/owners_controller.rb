class OwnersController < ApplicationController
    def new
      @owner=Owner.new
    end
    def show
      @owner=Owner.new(owner_params)
      if @owner.save
        session[:owner_id]=@owner.id
        redirect_to rides_path, notice: "Suceessfully Created Account"
      else
        render :new
      end
    end
    private
    def owner_params
        params.require(:owner).permit(:name, :email, :phone, :password, :password_confirmation)
    end
end
  