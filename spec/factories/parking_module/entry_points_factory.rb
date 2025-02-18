FactoryBot.define do
  factory :entry_point, class: ParkingModule::EntryPoint do
    name { "A" }
    association :parking_lot
  end
end
