class Vehicle < ApplicationRecord
  validates :plate_number, presence: true, uniqueness: true
  validates :vehicle_type, presence: true
  enum :vehicle_type, [ :small, :medium, :large ]
end
