class ParkingModule::ParkingRate < ApplicationRecord
  RETURN_WINDOW = 1.hour
  FLAT_HOURS = 3

  monetize :base_rate_cents, as: :base_rate
  monetize :hourly_rate_cents, as: :hourly_rate
  monetize :daily_rate_cents, as: :daily_rate

  belongs_to :slot_type, class_name: "ParkingModule::SlotType"

  def self.latest
    order(created_at: :desc).first
  end
end
