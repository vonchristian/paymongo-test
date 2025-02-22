class ParkingModule::ParkingSlot < ApplicationRecord
  belongs_to :parking_lot, class_name: "ParkingModule::ParkingLot"
  belongs_to :slot_type, class_name: "ParkingModule::SlotType"
  belongs_to :entry_point, class_name: "ParkingModule::EntryPoint"

  scope :available, -> { where(occupied: false) }
  delegate :name, to: :slot_type, prefix: true

  def self.assign_slot(slot_types:, entry_point:) # Nearest available slot to an entry point
    available
      .where(slot_type: entry_point.parking_lot.slot_types.where(name: slot_types), parking_lot: entry_point.parking_lot)
      .order(Arel.sql("distances->>'#{entry_point.id}' ASC"))
      .first
  end

  def rate
    slot_type.parking_rates.latest
  end
end
