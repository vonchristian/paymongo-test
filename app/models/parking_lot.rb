class ParkingLot < ApplicationRecord
  validates :name, :location, presence: true
end
