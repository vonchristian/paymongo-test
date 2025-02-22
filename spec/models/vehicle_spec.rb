require 'rails_helper'

RSpec.describe Vehicle, type: :model do
  describe "validations" do
    it { is_expected.to validate_presence_of :plate_number }
    it { is_expected.to validate_presence_of :vehicle_type }
  end

  describe "#allowed_slot_types" do
    context 'when vehicle is small' do
      it do
        vehicle = create(:vehicle, vehicle_type: 'small')

        expect(vehicle.allowed_slot_types).to eq([ "small", "medium", "large" ])
      end
    end

    context 'when vehicle is medium' do
      it do
        vehicle = create(:vehicle, vehicle_type: 'medium')

        expect(vehicle.allowed_slot_types).to eq([ "medium", "large" ])
      end
    end

    context 'when vehicle is large' do
      it do
        vehicle = create(:vehicle, vehicle_type: 'large')

        expect(vehicle.allowed_slot_types).to eq([ "large" ])
      end
    end
  end
end
