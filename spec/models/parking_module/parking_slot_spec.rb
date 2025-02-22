require 'rails_helper'

RSpec.describe ParkingModule::ParkingSlot, type: :model do
  describe "associations" do
    it { is_expected.to belong_to :parking_lot }
    it { is_expected.to belong_to :slot_type }
    it { is_expected.to belong_to :entry_point }
  end

  describe ".assign_slot" do
    let(:parking_lot) { create(:parking_lot) }
    let(:entry_point) { create(:entry_point, parking_lot: parking_lot) }
    let(:small_slot_type) { create(:slot_type, name: "small", parking_lot: parking_lot) }
    let(:medium_slot_type) { create(:slot_type, name: "medium", parking_lot: parking_lot) }
    let(:large_slot_type) { create(:slot_type, name: "large", parking_lot: parking_lot) }

    let!(:small_slot) do
      create(:parking_slot, slot_type: small_slot_type, parking_lot: parking_lot, occupied: false, distances: { entry_point.id => 5 })
    end

    let!(:medium_slot) do
      create(:parking_slot, slot_type: medium_slot_type, parking_lot: parking_lot, occupied: false, distances: { entry_point.id => 10 })
    end

    let!(:large_slot) do
      create(:parking_slot, slot_type: large_slot_type, parking_lot: parking_lot, occupied: false, distances: { entry_point.id => 15 })
    end

    context "when an exact match slot type is available" do
      it "assigns the correct small slot" do
        assigned_slot = described_class.assign_slot(slot_types: [ "small" ], entry_point: entry_point)
        expect(assigned_slot).to eq(small_slot)
      end

      it "assigns the correct medium slot" do
        assigned_slot = described_class.assign_slot(slot_types: [ "medium" ], entry_point: entry_point)
        expect(assigned_slot).to eq(medium_slot)
      end

      it "assigns the correct large slot" do
        assigned_slot = described_class.assign_slot(slot_types: [ "large" ], entry_point: entry_point)
        expect(assigned_slot).to eq(large_slot)
      end
    end

    context "when an exact match is unavailable" do
      before { small_slot.update(occupied: true) }

      it "assigns a medium slot for a small vehicle if no small slots are available" do
        assigned_slot = described_class.assign_slot(slot_types: [ "small", "medium", "large" ], entry_point: entry_point)
        expect(assigned_slot).to eq(medium_slot)
      end
    end

    context "when only large slots are available for a small vehicle" do
      before do
        small_slot.update(occupied: true)
        medium_slot.update(occupied: true)
      end

      it "assigns a large slot for a small vehicle" do
        assigned_slot = described_class.assign_slot(slot_types: [ "small", "medium", "large" ], entry_point: entry_point)
        expect(assigned_slot).to eq(large_slot)
      end
    end

    context "when all allowed slots are occupied" do
      before do
        small_slot.update(occupied: true)
        medium_slot.update(occupied: true)
        large_slot.update(occupied: true)
      end

      it "returns nil" do
        assigned_slot = ParkingModule::ParkingSlot.assign_slot(slot_types: "small", entry_point: entry_point)
        expect(assigned_slot).to be_nil
      end
    end
  end
end
