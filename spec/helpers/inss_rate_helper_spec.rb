require 'rails_helper'

RSpec.describe InssRateHelper, type: :helper do
  describe "#inss_rate_labels" do
    it "returns the correct human-readable INSS rate labels" do
      expected_labels = {
        up_to_1518: 'Até 1.518,00',
        from_1518_to_2793_88: 'De 1.518,01 até 2.793,88',
        from_2793_89_to_4190_83: 'De 2.793,89 até 4.190,83',
        from_4190_84_to_8157_41: 'De 4.190,84 até 8.157,41 e valores acima'
      }

      expect(helper.inss_rate_labels).to eq(expected_labels)
    end
  end
end
