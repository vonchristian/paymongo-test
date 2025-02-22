class ParkingModule::ExitParkingService < ActiveInteraction::Base
  object :parking_ticket

  def execute
    set_exit_time
    update_slot_to_available
    # accept_payment
  end

  private

  def exit_time
    parking_ticket.update(exit_time: Time.zone.now)
  end

  def update_slot_to_available
    parking_ticket.parking_slot.update(occupied: false)
  end
end
