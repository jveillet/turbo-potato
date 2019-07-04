class RidesController < ApplicationController
  ##
  # Displays all the existing rides
  #
  def index
    @rides = Ride.all
  end

  ##
  # Displays a ride
  # @param id [String] A ride unique Id
  #
  def show
    @ride = Ride.find(params[:id])
  end
end
