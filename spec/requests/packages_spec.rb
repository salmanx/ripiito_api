# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Packages API', type: :request do
  let(:plan) { create(:plan) }

  let(:valid_attributes) do
    {
      package: {
        name: Faker::Company.name[0...10],
        billing_period: 1,
        billing_period_unit: 'MONTH',
        auto_renewable: false,
        cancelable: true,
        status: 'DRAFT',
        package_type: 'REQUIRED',
        pricing_model: 'FIXED',
        pricing_type: 'RECURRING',
        plan_id: plan.id,
        package_price_attributes: {
          price: 100,
        },
      },
    }
  end

  let(:invalid_attributes) do
    {
      package: {
        name: '',
        plan_id: plan.id,
        package_price_attributes: {
          price: 100,
        },
      },
    }
  end

  describe 'GET /packages/:id' do
    let!(:package) { create(:package) }

    it 'returns a package' do
      get package_path(package.id)
      expect(response).to have_http_status(:ok)
      expect(json_response['name']).to eq(package.name)
    end
  end

  describe 'POST /packages' do
    context 'with valid params' do
      it 'creates a package' do
        expect do
          post packages_path, params: valid_attributes
        end.to change(Package, :count).by(1)
        expect(response).to have_http_status(:created)
      end
    end

    context 'with invalid params' do
      it 'returns errors' do
        post packages_path, params: invalid_attributes
        expect(response).to have_http_status(:conflict)
        expect(json_response['errors']).to include('name')
      end
    end
  end
end
