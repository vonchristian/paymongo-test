require 'rails_helper'

RSpec.describe ParkingModule::ParkingSlot, type: :model do
  describe "associations" do
    it { is_expected.to belong_to :parking_lot }
    it { is_expected.to belong_to :slot_type }
    it { is_expected.to belong_to :entry_point }
  end
end
