class Vehicle < ApplicationRecord
  validates :plate_number, presence: true, uniqueness: true
  validates :vehicle_type, presence: true

  has_many :parking_tickets, class_name: "ParkingModule::ParkingTicket"

  enum :vehicle_type, {
    small: "small",
    medium: "medium",
    large: "large"
  }


  def allowed_slot_types
    return [ "small", "medium", "large" ] if small?
    return [ "medium", "large" ] if medium?

    [ "large" ]
  end

  def last_exit_time
    parking_tickets.order(exit_time: :desc).first&.exit_time
  end
end
