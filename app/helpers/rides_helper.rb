module RidesHelper
  def log_state(previous_state, ride)
    logger.info "State changed from #{previous_state} to #{@ride.state} for ride n°#{@ride.code}"
  end
end
