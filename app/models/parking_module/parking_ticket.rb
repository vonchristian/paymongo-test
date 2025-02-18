class ParkingModule::ParkingTicket < ApplicationRecord
  belongs_to :vehicle
  belongs_to :parking_slot
  belongs_to :entry_point
  validates :entry_time, presence: true
  validate :exit_time_after_entry_time

  private

  def exit_time_after_entry_time
    return if entry_time.nil? || exit_time.nil?

    if exit_time.to_i <= entry_time.to_i
      errors.add(:exit_time, "must be after entry time")
    end
  end
end
