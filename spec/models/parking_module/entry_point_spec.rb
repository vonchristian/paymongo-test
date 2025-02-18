require 'rails_helper'

RSpec.describe ParkingModule::EntryPoint, type: :model do
  describe "associations" do
    it { is_expected.to belong_to :parking_lot }
  end

  describe "validations" do
    it "unique name scoped to parking lot" do
      existing_record = create(:entry_point)
      new_record = build(:entry_point, parking_lot: existing_record.parking_lot)

      new_record.save

      expect(new_record.errors[:name]).to include("has already been taken")
    end
  end
end
