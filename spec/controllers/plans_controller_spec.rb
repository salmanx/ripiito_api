# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PlansController, type: :controller do
  let(:plan) { create(:plan) }
  let(:tenant) { create(:tenant) }

  describe 'GET #show' do
    it 'returns the plan' do
      get :show, params: { id: plan.id }
      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body)['name']).to eq(plan.name)
    end
  end

  describe 'POST #create' do
    context 'with valid params' do
      let(:valid_params) do
        {
          plan: {
            name: Faker::Company.name[0...10],
            # billing_period: 1,
            # billing_period_unit: 'MONTH',
            duration: 120,
            # base_price: 1000.00,
            tenant_id: tenant.id,
          },
        }
      end

      it 'creates a new plan' do
        expect do
          post :create, params: valid_params
        end.to change(Plan, :count).by(1)
        expect(response).to have_http_status(:created)
      end
    end

    context 'with invalid params' do
      let(:invalid_params) do
        {
          plan: {
            name: '',
            duration: 0,
            tenant_id: tenant.id,
          },
        }
      end

      it 'returns errors' do
        post :create, params: invalid_params
        expect(response).to have_http_status(:conflict)
        body = JSON.parse(response.body)
        # puts body['errors'].keys
        expect(body['errors'].keys).to include(
          'name',
        )
      end
    end
  end
end
