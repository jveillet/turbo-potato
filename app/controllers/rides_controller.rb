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
  # Changes the state of the ride to "Started"
  # @param id [String] A ride unique Id
  #
  def start_ride
    @ride = Ride.find(params[:id])
    previous_state = @ride.state
    if @ride.created?
      @ride.start
      @ride.update(state: @ride.state)
      log_state(previous_state, @ride)
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
      log_state(previous_state, @ride)
    end

    redirect_to rides_path
  end
end
