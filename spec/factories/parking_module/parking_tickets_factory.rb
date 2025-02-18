FactoryBot.define do
  factory :parking_ticket, class: ParkingModule::ParkingTicket do
    association :vehicle
    association :parking_slot
    association :entry_point
    entry_time { "2025-02-18 16:25:08" }
    exit_time { "2025-02-18 18:25:08" }
  end
end
