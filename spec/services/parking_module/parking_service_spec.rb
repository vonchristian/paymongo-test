require 'rails_helper'

RSpec.describe ParkingModule::ParkingService, type: :service do
  let(:entry_point) { create(:entry_point) }
  let(:vehicle) { create(:vehicle, plate_number: "ABC123") }
  let(:parking_slot) { create(:parking_slot, occupied: false) }

  before do
    allow(Vehicle).to receive(:find_or_create_by).and_return(vehicle)
    allow(ParkingModule::ParkingSlot).to receive(:assign_slot).and_return(parking_slot)
  end

  context "when a parking slot is available" do
    it "creates a parking ticket and marks the slot as occupied" do
      service = described_class.run(plate_number: vehicle.plate_number, entry_point_id: entry_point.id.to_s, vehicle_type: vehicle.vehicle_type)

      expect(service).to be_valid
      expect(vehicle.parking_tickets.count).to eq(1)
      expect(parking_slot.reload.occupied).to be true
    end
  end

  context "when no parking slot is available" do
    before do
      allow(ParkingModule::ParkingSlot).to receive(:assign_slot).and_return(nil)
    end

    it "does not create a parking ticket and adds an error" do
      service = described_class.run(plate_number: vehicle.plate_number, entry_point_id: entry_point.id.to_s, vehicle_type: vehicle.vehicle_type)

      expect(service).not_to be_valid
      expect(service.errors[:base]).to include("No available slot")
      expect(vehicle.parking_tickets.count).to eq(0)
    end
  end
end
