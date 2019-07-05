module RidePayment
  include RidesHelper

  def bill(ride)
    return false unless ride.created?

    true
  end

  def reimburse(ride)
    return false unless ride_pending?(ride)

    true
  end

  def pay(ride)
    return false unless ride.started?

    true
  end
end
