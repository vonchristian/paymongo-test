class ParkingModule::ParkingLot < ApplicationRecord
  has_many :slot_types, class_name: "ParkingModule::SlotType"

  validates :name, :location, presence: true
end
