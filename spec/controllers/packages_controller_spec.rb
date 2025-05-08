# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PackagesController, type: :controller do
  let(:package) { create(:package) }
  let(:plan) { create(:plan) }

  describe 'GET #show' do
    it 'returns the package' do
      get :show, params: { id: package.id }
      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body)['name']).to eq(package.name)
    end
  end

  describe 'POST #create' do
    context 'with valid params' do
      let(:valid_params) do
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
          },
        }
      end

      it 'creates a new package' do
        expect do
          post :create, params: valid_params
        end.to change(Package, :count).by(1)
        expect(response).to have_http_status(:created)
      end
    end

    context 'with invalid params' do
      let(:invalid_params) do
        {
          package: {
            name: '',
            plan_id: plan.id,
          },
        }
      end

      it 'returns errors' do
        post :create, params: invalid_params
        expect(response).to have_http_status(:conflict)
        body = JSON.parse(response.body)
        expect(body['errors'].keys).to include(
          'name',
        )
      end
    end
  end
end
