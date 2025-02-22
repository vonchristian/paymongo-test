require 'rails_helper'

RSpec.describe ParkingModule::RateService, type: :service do
  let(:vehicle) { create(:vehicle) }
  let(:slot_type) { create(:slot_type) }
  let(:parking_slot) { create(:parking_slot, slot_type: slot_type) }
  let(:parking_ticket) { create(:parking_ticket, vehicle: vehicle, parking_slot: parking_slot, entry_time: entry_time, exit_time: exit_time) }
  let(:exit_time) { Time.zone.now }

  let!(:parking_rate) do
    create(:parking_rate, base_rate: 40, hourly_rate: 20, daily_rate: 5000, slot_type: slot_type)
  end

  describe "#execute" do
    subject(:service) { described_class.run!(parking_ticket: parking_ticket) }

    context "when vehicle is parked for 3 hours or less" do
      let(:entry_time) { 2.hours.ago }

      it "charges only the base rate" do
        expect(service).to eq(Money.new(40 * 100))
      end
    end

    context "when vehicle is parked for more than 3 hours but less than 24" do
      let(:entry_time) { 6.hours.ago }

      it "charges base rate + extra hours" do
        # 40 base + (3 extra hours * 20/hour)
        expect(service).to eq(Money.new((40 + (3 * 20)) * 100))
      end
    end

    context "when vehicle is parked for more than 24 hours" do
      let(:entry_time) { 30.hours.ago }


      it "charges daily rate for full days and extra hours separately" do
        # 1 full day (5000) + remaining 6 hours (40 base + 3 * 20)
        expected_charge = (5000 + (40 + (3 * 20))) * 100
        expect(service).to eq(Money.new(expected_charge))
      end
    end

    context "when continuous rate applies" do
      let!(:previous_ticket) do
        create(:parking_ticket, vehicle: vehicle, entry_time: 55.minutes.ago, exit_time: 50.minutes.ago)
      end
      let(:entry_time) { Time.zone.now }
      let(:exit_time) { 6.hour.from_now }

      it "applies continuous rate instead of new rate" do
        expected_charge = (40 + (3 * 20)) * 100
        expect(service).to eq(Money.new(expected_charge)) # same charge as if never left
      end
    end

    context "when continuous rate does NOT apply" do
      let!(:previous_ticket) do
        create(:parking_ticket, vehicle: vehicle, entry_time: 5.hours.ago, exit_time: 2.hours.ago)
      end

      let(:entry_time) { Time.zone.now }
      let(:exit_time) { 5.hours.from_now }

      it "calculates rate as a new parking instance" do
        expected_charge = (40 + (2 * 20)) * 100
        expect(service).to eq(Money.new(expected_charge)) # normal rate applies
      end
    end
  end
end
