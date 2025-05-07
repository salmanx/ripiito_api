# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Plans API', type: :request do
  let(:tenant) { create(:tenant) }

  let(:valid_attributes) do
    {
      plan: {
        name: Faker::Company.name[0...10],
        duration: 120,
        tenant_id: tenant.id,
      },
    }
  end

  let(:invalid_attributes) do
    {
      plan: {
        name: '',
        duration: 0,
        tenant_id: tenant.id,
      },
    }
  end

  describe 'GET /plans/:id' do
    let!(:plan) { create(:plan) }

    it 'returns a plan' do
      get plan_path(plan.id)
      expect(response).to have_http_status(:ok)
      expect(json_response['name']).to eq(plan.name)
    end
  end

  describe 'POST /plans' do
    context 'with valid params' do
      it 'creates a plan' do
        expect do
          post plans_path, params: valid_attributes
        end.to change(Plan, :count).by(1)
        expect(response).to have_http_status(:created)
      end
    end

    context 'with invalid params' do
      it 'returns errors' do
        post plans_path, params: invalid_attributes
        expect(response).to have_http_status(:conflict)
        expect(json_response['errors']).to include('name')
      end
    end
  end
end
