class ParkingModule::SlotType < ApplicationRecord
  belongs_to :parking_lot, class_name: "ParkingModule::ParkingLot"

  validates :name, presence: true, uniqueness: { scope: :parking_lot }
end
