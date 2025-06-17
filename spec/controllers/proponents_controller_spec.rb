require 'rails_helper'

RSpec.describe "/proponents", type: :request do
  let(:user) { create(:user) }
  let(:valid_attributes) do
    attributes_for(:proponent).merge(
      addresses_attributes: [attributes_for(:address)],
      contacts_attributes: [attributes_for(:contact)]
    )
  end

  let(:invalid_attributes) do
    {
      name: '',
      document: '123',
      salary: nil,
      inss_rate_type: nil,
      inss_rate: nil
    }
  end

  before do
    login_as user
  end

  describe "GET /index" do
    it "renders a successful response" do
      get proponents_path
      expect(response).to be_successful
    end
  end

  describe "GET /show" do
    it "renders a successful response" do
      proponent = create(:proponent)
      get proponent_path(proponent)
      expect(response).to be_successful
    end
  end

  describe "GET /new" do
    it "renders a successful response" do
      get new_proponent_path
      expect(response).to be_successful
    end
  end

  describe "GET /edit" do
    it "renders a successful response" do
      proponent = create(:proponent)
      get edit_proponent_path(proponent)
      expect(response).to be_successful
    end
  end

  describe "POST /create" do
    context "with valid parameters" do
      it "creates a new Proponent" do
        expect do
          post proponents_path, params: { proponent: valid_attributes }
        end.to change(Proponent, :count).by(1)
      end

      it "redirects to the created proponent" do
        post proponents_path, params: { proponent: valid_attributes }
        expect(response).to redirect_to(Proponent.last)
      end
    end

    context "with invalid parameters" do
      it "does not create a new Proponent" do
        expect do
          post proponents_path, params: { proponent: invalid_attributes }
        end.not_to change(Proponent, :count)
      end

      it "renders a successful response" do
        post proponents_path, params: { proponent: invalid_attributes }
        expect(response).to be_successful
      end
    end
  end

  describe "PATCH /update" do
    context "with valid parameters" do
      let(:new_attributes) do
        { name: 'Updated Name' }
      end

      it "updates the requested proponent" do
        proponent = create(:proponent)
        patch proponent_path(proponent), params: { proponent: new_attributes }
        proponent.reload
        expect(proponent.name).to eq('Updated Name')
      end

      it "redirects to the proponent" do
        proponent = create(:proponent)
        patch proponent_path(proponent), params: { proponent: new_attributes }
        expect(response).to redirect_to(proponent)
      end
    end

    context "with invalid parameters" do
      it "renders a successful response" do
        proponent = create(:proponent)
        patch proponent_path(proponent), params: { proponent: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_entity) # ou 200 se usar status padrão
      end
    end
  end

  describe "DELETE /destroy" do
    it "destroys the requested proponent" do
      proponent = create(:proponent)
      expect do
        delete proponent_path(proponent)
      end.to change(Proponent, :count).by(-1)
    end

    it "redirects to the proponents list" do
      proponent = create(:proponent)
      delete proponent_path(proponent)
      expect(response).to redirect_to(proponents_url)
    end
  end
end