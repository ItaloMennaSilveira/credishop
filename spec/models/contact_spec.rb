require 'rails_helper'

RSpec.describe Contact, type: :model do
  describe "associations" do
    it { should belong_to(:proponent) }
  end

  describe "enums" do
    it { should define_enum_for(:contact_type).with_values(phone: 1, email: 2, whatsapp: 3) }
  end

  describe "validations" do
    subject { build(:contact) }

    it { should validate_presence_of(:contact_type) }
    it { should validate_presence_of(:value) }
  end

  describe "custom validation: validate_value_format" do
    context "when contact_type is email" do
      it "is valid with a valid email" do
        contact = build(:contact, contact_type: :email, value: "test@example.com")
        expect(contact).to be_valid
      end

      it "is invalid with a malformed email" do
        contact = build(:contact, contact_type: :email, value: "invalid-email")
        expect(contact).not_to be_valid
        expect(contact.errors[:value]).to include("deve ser um endereço de email válido")
      end
    end

    context "when contact_type is phone or whatsapp" do
      it "normalizes and accepts phone numbers with symbols" do
        contact = build(:contact, contact_type: :phone, value: "(53) 98123-4567")
        contact.valid?
        expect(contact.value).to eq("53981234567")
      end

      it "truncates phone number if longer than 14 numeric digits" do
        contact = build(:contact, contact_type: :whatsapp, value: "+55 (53) 98123-4567")
        contact.valid?
        expect(contact.value).to eq("5553981234567")
      end
    end

    context "when contact_type is something invalid" do
      it "adds an error to contact_type" do
        contact = build(:contact, contact_type: nil, value: "something")
        contact.validate
        expect(contact.errors[:contact_type]).to include("é inválido").or include("can't be blank")
      end
    end
  end
end
