require 'rails_helper'

RSpec.describe ParkingModule::DurationService, type: :service do
  let(:vehicle) { create(:vehicle) }
  let(:entry_time) { Time.zone.now - 6.hours }
  let(:exit_time) { Time.zone.now }
  let(:parking_ticket) { create(:parking_ticket, vehicle: vehicle, entry_time: entry_time, exit_time: exit_time) }

  describe "#execute" do
    subject(:service) { described_class.run!(parking_ticket: parking_ticket) }

    context "when vehicle is parked for less than a full day" do
      it "calculates total hours correctly" do
        expect(service[:total_hours]).to eq(6)
        expect(service[:full_days]).to eq(0)
        expect(service[:remaining_hours]).to eq(6)
      end
    end

    context "when vehicle is parked for more than 24 hours" do
      let(:entry_time) { Time.zone.now - 30.hours }

      it "calculates full days and remaining hours correctly" do
        expect(service[:total_hours]).to eq(30)
        expect(service[:full_days]).to eq(1)
        expect(service[:remaining_hours]).to eq(6)
      end
    end

    context "when vehicle is parked exactly for a full day" do
      let(:entry_time) { Time.zone.now - 24.hours }

      it "calculates full days with zero remaining hours" do
        expect(service[:total_hours]).to eq(24)
        expect(service[:full_days]).to eq(1)
        expect(service[:remaining_hours]).to eq(0)
      end
    end

    context "when continuous rate should apply" do
      it "detects continuous parking correctly" do
        create(:parking_ticket, vehicle: vehicle, entry_time: entry_time - 1.hour, exit_time: entry_time + 30.minutes)

        expect(service[:continuous_rate_applies]).to be true
      end
    end

    context "when continuous rate should NOT apply" do
      let!(:previous_ticket) do
        create(:parking_ticket, vehicle: vehicle, entry_time: entry_time - 2.hours, exit_time: entry_time - 2.hours + 10.minutes)
      end

      it "does not apply continuous rate when return window exceeded" do
        expect(service[:continuous_rate_applies]).to be false
      end
    end
  end
end
