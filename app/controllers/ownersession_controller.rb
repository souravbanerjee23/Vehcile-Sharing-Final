class OwnersessionController < ApplicationController
    def new
    end
    def create
        owner=Owner.find_by(email: params[:email])
        if owner.present? && owner.authenticate(params[:password])
            session[:owner_id]=owner.id
            redirect_to root_path, notice: "Log in Successfully"
        else
            flash[:alert]="Invalid credentials"
            render :new
        end
    end
    def destroy
        session[:owner_id] = nil
        redirect_to root_path, notice: "Logged Out"
    end
end