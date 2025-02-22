class ParkingModule::RateService < ActiveInteraction::Base
  object :parking_ticket, class: ParkingModule::ParkingTicket


  def execute
    return apply_continuous_rate if duration[:continuous_rate_applies]
    if duration[:total_hours] <= ParkingModule::ParkingRate::FLAT_HOURS
      return parking_rate.base_rate
    end

    daily_fee = duration[:full_days] * parking_rate.daily_rate
    extra_hours_fee = calculate_extra_hours_fee(duration[:remaining_hours])

    (daily_fee + extra_hours_fee)
  end

  private

  def duration
    @duration ||= parking_ticket.duration
  end

  def calculate_extra_hours_fee(hours)
    return 0 if hours.zero?
    return parking_rate.base_rate if hours <= ParkingModule::ParkingRate::FLAT_HOURS

    exceeding_hours = hours - ParkingModule::ParkingRate::FLAT_HOURS
    parking_rate.base_rate + (exceeding_hours * parking_rate.hourly_rate)
  end

  def apply_continuous_rate
    return parking_rate.base_rate if duration[:total_hours] <= ParkingModule::ParkingRate::FLAT_HOURS
    parking_rate.base_rate + ((duration[:total_hours] - ParkingModule::ParkingRate::FLAT_HOURS) * parking_rate.hourly_rate)
  end

  def parking_rate
    parking_ticket.parking_slot.rate
  end
end
