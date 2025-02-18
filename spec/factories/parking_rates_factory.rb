FactoryBot.define do
  factory :parking_rate, class: ParkingModule::ParkingRate do
    association :slot_type
    base_rate_cents { 400 }
    hourly_rate_cents { 2000 }
    daily_rate_cents { 50000 }
  end
end
