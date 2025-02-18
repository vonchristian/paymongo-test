FactoryBot.define do
  factory :parking_lot, class: ParkingModule::ParkingLot do
    name { "Object-Oriented Mall" }
    location { "Makati, Philippines" }
  end
end
