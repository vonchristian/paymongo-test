FactoryBot.define do
  factory :parking_slot, class: ParkingModule::ParkingSlot do
    association :parking_lot
    association :slot_type
    association :entry_point
    distances { "#{entry_point.id} => 10" }
    occupied { false }
  end
end
