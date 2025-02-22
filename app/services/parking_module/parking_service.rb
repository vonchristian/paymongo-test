class ParkingModule::ParkingService < ActiveInteraction::Base
  string :plate_number, :vehicle_type, :entry_point_id

  def execute
    return errors.add(:base, "No available slot") if available_slot.blank?

      update_slot_to_occupied
      create_ticket
  end

  private

  def update_slot_to_occupied
    available_slot.update(occupied: true)
  end

  def create_ticket
  vehicle.parking_tickets.create!(
    parking_slot: available_slot,
    entry_point: entry_point,
    entry_time: Time.current
    )
  end

  def available_slot
    @available_slot ||= ParkingModule::ParkingSlot.assign_slot(slot_types: vehicle.allowed_slot_types, entry_point: entry_point)
  end

  def vehicle
    @vehicle ||= Vehicle.find_or_create_by(plate_number: plate_number, vehicle_type: vehicle_type)
  end

  def entry_point
    @entry_point ||= ParkingModule::EntryPoint.find(entry_point_id)
  end
end
