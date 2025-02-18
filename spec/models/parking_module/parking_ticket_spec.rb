require 'rails_helper'

RSpec.describe ParkingModule::ParkingTicket, type: :model do
  describe 'associations' do
    it { is_expected.to belong_to :vehicle }
    it { is_expected.to belong_to :entry_point }
    it { is_expected.to belong_to :parking_slot }
  end
  describe 'validations' do
    it { is_expected.to validate_presence_of :entry_time }

    it 'is valid when exit_time is after entry_time' do
      ticket = build(:parking_ticket, entry_time: Time.current, exit_time: Time.current + 1.hour)
      expect(ticket).to be_valid
    end

    it 'is invalid when exit_time is before entry_time' do
      ticket = build(:parking_ticket, entry_time: Time.current, exit_time: Time.current - 1.hour)
      expect(ticket).not_to be_valid
      expect(ticket.errors[:exit_time]).to include("must be after entry time")
    end

    it 'is invalid when exit_time is equal to entry_time' do
      ticket = build(:parking_ticket, entry_time: Time.current, exit_time: Time.current)
      expect(ticket).not_to be_valid
      expect(ticket.errors[:exit_time]).to include("must be after entry time")
    end
  end
end
