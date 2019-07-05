module RidesHelper
  def log_state(code, previous_state, state)
    logger.info "State changed from #{previous_state} to #{state} for ride n°#{code}"
  end

  def log_error(message, code)
    logger.info "#{message} with n°#{code}"
  end

  def ride_pending?(ride)
    ride.created? || ride.started?
  end
end
