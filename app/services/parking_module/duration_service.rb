class ParkingModule::DurationService < ActiveInteraction::Base
    object :parking_ticket, class: ParkingModule::ParkingTicket

  FULL_DAY_HOURS = 24

  def execute
    {
      total_hours: total_hours,
      full_days: total_hours / FULL_DAY_HOURS,
      remaining_hours: total_hours % FULL_DAY_HOURS,
      continuous_rate_applies: continuous_rate_applies?
    }
  end

  private

  def total_hours
    exit_time = parking_ticket.exit_time.presence || Time.zone.now
    ((exit_time - parking_ticket.entry_time) / 1.hour).round
  end

  def continuous_rate_applies?
    return false if parking_ticket.vehicle.parking_tickets.where.not(id: parking_ticket.id).empty?
    return false unless (last_exit_time = last_parking_ticket&.exit_time)

    (parking_ticket.entry_time - last_exit_time) <= ParkingModule::ParkingRate::RETURN_WINDOW
  end

  def last_parking_ticket
    parking_ticket.vehicle.parking_tickets.where.not(id: parking_ticket.id).order(exit_time: :desc).first
  end
end
