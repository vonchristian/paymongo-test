class ParkingModule::ParkingSlot < ApplicationRecord
  belongs_to :parking_lot, class_name: "ParkingModule::ParkingLot"
  belongs_to :slot_type, class_name: "ParkingModule::SlotType"
  belongs_to :entry_point, class_name: "ParkingModule::EntryPoint"
end
