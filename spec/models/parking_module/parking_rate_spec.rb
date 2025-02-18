require 'rails_helper'

RSpec.describe ParkingModule::ParkingRate, type: :model do
  describe "associations" do
    it { is_expected.to belong_to :slot_type }
  end
  describe "monetize" do
    it { is_expected.to monetize(:base_rate) }
    it { is_expected.to monetize(:hourly_rate) }
    it { is_expected.to monetize(:daily_rate) }
  end
end
