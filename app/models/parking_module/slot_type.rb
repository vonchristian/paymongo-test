class ParkingModule::SlotType < ApplicationRecord
  has_many :parking_rates, class_name: "ParkingModule::ParkingRate"
  belongs_to :parking_lot, class_name: "ParkingModule::ParkingLot"
  enum :name, {
    small: "small",
    medium: "medium",
    large: "large"
  }

  validates :name, presence: true, uniqueness: { scope: :parking_lot }
end
