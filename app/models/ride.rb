require 'securerandom'

class Ride < ApplicationRecord
  after_initialize :init

  STATE_CREATED = 'created'
  STATE_STARTED = 'started'
  STATE_CANCELED = 'cancelled'

  STATES = [
    STATE_STARTED,
    STATE_STARTED,
    STATE_CANCELED
  ]

  ##
  # Override the record with default values.
  #
  def init
    self.state  ||= STATE_CREATED
    self.code ||= generate_code
  end

  ##
  # Generates a unique 4 characters code for the rides
  #
  def generate_code
    SecureRandom.alphanumeric(4)
  end
end
