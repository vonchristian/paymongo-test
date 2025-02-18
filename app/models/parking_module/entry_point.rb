class ParkingModule::EntryPoint < ApplicationRecord
  validates :name, presence: true, uniqueness: { scope: :parking_lot }
  belongs_to :parking_lot, class_name: "ParkingModule::ParkingLot"
end
