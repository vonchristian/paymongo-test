require 'rails_helper'

RSpec.describe Vehicle, type: :model do
  describe "validations" do
    it { is_expected.to validate_presence_of :plate_number }
    it { is_expected.to validate_presence_of :vehicle_type }
  end
end
