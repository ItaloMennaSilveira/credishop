require 'rails_helper'

RSpec.describe Address, type: :model do
  let(:proponent) { create(:proponent) }

  subject do
    described_class.new(
      proponent: proponent,
      street: 'Rua Exemplo',
      number: '123',
      zip_code: '12345678',
      city: 'Pelotas',
      state: 'RS'
    )
  end

  it "is valid with all attributes" do
    expect(subject).to be_valid
  end

  it "is invalid without street" do
    subject.street = nil
    expect(subject).not_to be_valid
    expect(subject.errors[:street]).to include("can't be blank")
  end

  it "is invalid without number" do
    subject.number = nil
    expect(subject).not_to be_valid
    expect(subject.errors[:number]).to include("can't be blank")
  end

  it "is invalid without zip_code" do
    subject.zip_code = nil
    expect(subject).not_to be_valid
    expect(subject.errors[:zip_code]).to include("can't be blank")
  end

  it "is invalid if zip_code has wrong format" do
    subject.zip_code = "12345-678"
    expect(subject).not_to be_valid
    expect(subject.errors[:zip_code]).to include("deve conter exatamente 8 dígitos, sem hífen")
  end

  it "is invalid without city" do
    subject.city = nil
    expect(subject).not_to be_valid
    expect(subject.errors[:city]).to include("can't be blank")
  end

  it "is invalid without state" do
    subject.state = nil
    expect(subject).not_to be_valid
    expect(subject.errors[:state]).to include("can't be blank")
  end
end
