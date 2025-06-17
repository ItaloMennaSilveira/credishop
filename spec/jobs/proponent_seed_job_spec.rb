require 'rails_helper'

RSpec.describe ProponentSeedJob, type: :job do
  let(:quantity) { 20 }

  before do
    Proponent.destroy_all
    User.destroy_all
    Address.destroy_all
    Contact.destroy_all
  end

  describe "#perform" do
    it "clears the database and creates the expected number of proponents and one admin user" do
      expect {
        described_class.perform_now(quantity)
      }.to change(Proponent, :count).by(quantity)
       .and change(User, :count).to(1)
    end

    it "creates at least one address and one contact" do
      described_class.perform_now(quantity)

      expect(Address.count).to be > 0
      expect(Contact.count).to be > 0
    end
  end
end
