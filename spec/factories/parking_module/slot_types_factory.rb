FactoryBot.define do
  factory :slot_type, class: ParkingModule::SlotType do
    association :parking_lot
    name { "small" }
  end
end
