class RidesController < ApplicationController
  before_action :set_ride, only: %i[ show edit update destroy ]

  # GET /rides or /rides.json
  def index
    @rides = Ride.all
  end
 
  # GET /rides/1 or /rides/1.json
  def show
  end

  # GET /rides/new
  def new
    @ride = Ride.new
  end

  # GET /rides/1/edit
  def edit
  end

  # POST /rides or /rides.json
  def create
    @ride = Ride.new(ride_params)
    
    respond_to do |format|
      if @ride.save
        # from @ride we will get ride id and from ride id we will fetch rent record
        # and do source and destination validations
        # seat validations
        # and cost validations 
        # booking status need to be added
        format.html { redirect_to @ride, notice: "Ride was successfully created." }
        format.json { render :show, status: :created, location: @ride }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @ride.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /rides/1 or /rides/1.json
  def update
    respond_to do |format|
      if @ride.update(ride_params)
        format.html { redirect_to @ride, notice: "Ride was successfully updated." }
        format.json { render :show, status: :ok, location: @ride }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @ride.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /rides/1 or /rides/1.json
  def destroy
    @ride.destroy
    respond_to do |format|
      format.html { redirect_to rides_url, notice: "Ride was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_ride
      @ride = Ride.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def ride_params
      params.require(:ride).permit(:vehicle_no, :seats, :start_point, :stop1, :stop2, :stop3, :stop4, :final_stop, :cost, :date, :vehicletype, :discount, :owner_id)#: )
    end
end
