class RentsController < ApplicationController
  before_action :set_rent, only: %i[ show edit update destroy ]


  # GET /rents or /rents.json
  def index
    @rents = Rent.all
  end
  

  def viewrides
    @rides = Ride.all
  end


  # def viewrents
  #   @rides = Rent.all
  # end


  # GET /rents/1 or /rents/1.json
  def show
  end


  def success
  end


  def failure
  end


  # GET /rents/new
  def new
    @rent = Rent.new
  end


  # GET /rents/1/edit
  def edit
    @rent = Rent.find(params[:id])
  end


  # POST /rents or /rents.json
  def create
    @rent = Rent.new(rent_params)
    #@ride = Ride.where(id: @rent.ride.id)
    #@ride = Ride.find(@rent.ride_id)
    #puts 'Busy at the moment!!'
    respond_to do |format|
      if @rent.save 
        @ride = Ride.find(@rent.ride_id)
        if @ride.seats < @rent.seats
          @rent.waiting = true
          @rent.status = false
          # waiting case
        else
          @rent.waiting = false
          @rent.status = false
          # bargain case
        end
        @rent.save
        format.html { redirect_to @rent, notice: "Rent was successfully created." }
        format.json { render :show, status: :created, location: @rent }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @rent.errors, status: :unprocessable_entity }
      end
    end
  end

  
  # PATCH/PUT /rents/1 or /rents/1.json
  def update
    @rent = Rent.find(params[:id])
    if @rent.update(bargain_params)
      @ride = Ride.find(@rent.ride_id)
      progress = 1

      if @ride.stop1
        progress += 1
      end
      if @ride.stop2
        progress += 1
      end
      if @ride.stop3
        progress += 1
      end
      if @ride.stop4
        progress += 1
      end

      cost = @ride.cost/progress
      ct = 0 
      if @rent.start_location == @ride.start_point
        if @rent.destination == @ride.stop1
          ct += cost
        end
        if @rent.destination == @ride.stop2
          ct += cost*2
        end
        if @rent.destination == @ride.stop3
          ct += cost*3
        end
        if @rent.destination == @ride.stop4
          ct += cost*4
        end
        if @rent.destination == @ride.final_stop
          ct += cost*5
        end
      end
      if @rent.start_location == @ride.stop1
        if @rent.destination == @ride.stop2
          ct += cost
        end
        if @rent.destination == @ride.stop3
          ct += cost*2
        end
        if @rent.destination == @ride.stop4
          ct += cost*3
        end
        if @rent.destination == @ride.final_stop
          ct += cost*4
        end
      end
      if @rent.start_location == @ride.stop2
        if @rent.destination == @ride.stop3
          ct += cost
        end
        if @rent.destination == @ride.stop4
          ct += cost*2
        end
        if @rent.destination == @ride.final_stop
          ct += cost*3
        end
      end
      if @rent.start_location == @ride.stop3
        if @rent.destination == @ride.stop4
          ct += cost
        end
        if @rent.destination == @ride.final_stop
          ct += cost*2
        end
      end
      if @rent.start_location == @ride.stop4
        if @rent.destination == @ride.final_stop
          ct += cost
        end
      end

      # in ct we have the cost to be paid by the passenger for the ride
      #if @rent.price >= (@ride.cost-((@ride.cost*@ride.discount)/100)) && @rent.price <= @ride.cost && @ride.seats >= @rent.seats 
      if @rent.price >= (ct-((ct*@ride.discount)/100)) && @rent.price <= ct && @ride.seats >= @rent.seats 
        @ride.seats -= @rent.seats
        @rent.status = true
        @rent.save
        @ride.save
        redirect_to "/rents"
      else
        render  :failure
    end
  end
  end


  # DELETE /rents/1 or /rents/1.json
  def destroy
    @ride = Ride.find(@rent.ride.id)
    if @rent.status == true
      @ride.seats += @rent.seats
      @ride.save
      id = @rent.ride_id
      x = 1
      p = Rent.last.id
      while x <= p
        begin
          @nr = Rent.find(x)
          #puts @nr
          #puts @id
          #puts @ride.seats
          if @nr.rent_id == id && @nr.waiting == true && @nr.seats <= @ride.seats
            @nr.waiting = false
            @nr.status = false
            @ride.seats -= @nr.seats
            @ride.save
            @nr.save
          end
        rescue => e
          s = x
        end
        x += 1
      end
    # come from last and use a array to store all the id of the rent and reverse the array
    # and work in fifo direction of all the entries!!
    end
    @rent.destroy
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_rent
      @rent = Rent.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def rent_params
      params.require(:rent).permit(:start_location, :destination, :seats, :ride_id, :date)
    end

    def bargain_params
      params.require(:rent).permit(:ride_id, :price)
    end
end
