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
    if @ride.created?
      @ride.start
      @ride.update(state: @ride.state)
      log_state('created', @ride)
    end

    redirect_to rides_path
  end
end
