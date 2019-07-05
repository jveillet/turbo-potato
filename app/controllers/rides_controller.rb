class RidesController < ApplicationController
  include RidesHelper
  ##
  # Displays all the existing rides
  #
  def index
    @rides = Ride.all.order('created_at')
  end

  ##
  # Displays a ride
  # @param id [String] A ride unique Id
  #
  def show
    @ride = Ride.find(params[:id])
  end

  ##
  # Instanciate a new empty Ride
  #
  def new
    @ride = Ride.new
  end

  ##
  # Creates a new Ride record
  # @param from [String] Departure of the ride
  # @param to [String] Destination of the ride
  #
  def create
    @ride = Ride.create(ride_params)
    log_state(@ride.code, 'new', @ride.state)

    redirect_to rides_path
  end

  ##
  # Changes the state of the ride to "Started"
  # @param id [String] A ride unique Id
  #
  def start_ride
    @ride = Ride.find(params[:id])
    previous_state = @ride.state
    if @ride.created?
      @ride.start
      @ride.update(state: @ride.state)
      log_state(@ride.code, previous_state, @ride.state)
    end

    redirect_to rides_path
  end

  ##
  # Changes the state of the ride to "Cancelled"
  # @param id [String] A ride unique Id
  #
  def cancel_ride
    @ride = Ride.find(params[:id])
    previous_state = @ride.state
    if @ride.started? || @ride.created?
      @ride.cancel
      @ride.update(state: @ride.state)
      log_state(@ride.code, previous_state, @ride.state)
    end

    redirect_to rides_path
  end

  ##
  # Deletes a ride
  # @param id [String] A ride unique Id
  #
  def destroy
    @ride = Ride.find(params[:id])
    previous_state = @ride.state
    @ride.destroy
    if @ride.destroyed?
      log_state(@ride.code, previous_state, 'destoyed')
    else
      log_error("Error while deleting ride", @ride.code)
    end
    redirect_to rides_path
  end

  private
  def ride_params
    params.require(:ride).permit(:from, :to)
  end
end
