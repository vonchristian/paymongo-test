require 'rails_helper'

RSpec.describe ParkingModule::SlotType, type: :model do
  describe "associations" do
    it { is_expected.to belong_to :parking_lot }
  end

  describe "validations" do
    it "unique name scoped to parking lot" do
      existing_record = create(:slot_type, name: "small")
      new_record = build(:slot_type, name: "small", parking_lot: existing_record.parking_lot)

      new_record.save

      expect(new_record.errors[:name]).to include("has already been taken")
    end
  end
end
