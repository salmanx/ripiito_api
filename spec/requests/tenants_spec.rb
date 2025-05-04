# frozen_string_literal: true

# spec/requests/tenants_spec.rb
require 'rails_helper'

RSpec.describe 'Tenants API', type: :request do
  let(:valid_attributes) do
    {
      tenant: {
        name: Faker::Company.name[0...10],
        url: Faker::Internet.url(host: 'test'),
        location: Faker::Address.full_address[0..15],
      },
    }
  end

  let(:invalid_attributes) do
    {
      tenant: {
        name: '',
        ip: 'invalid',
        url: 'not-a-url',
        location: 'X',
      },
    }
  end

  describe 'GET /tenants/:id' do
    let!(:tenant) { create(:tenant) }

    it 'returns a tenant' do
      get tenant_path(tenant.id)
      expect(response).to have_http_status(:ok)
      expect(json_response['uuid']).to eq(tenant.uuid)
    end
  end

  describe 'POST /tenants' do
    context 'with valid params' do
      it 'creates a tenant' do
        expect do
          post tenants_path, params: valid_attributes
        end.to change(Tenant, :count).by(1)
        expect(response).to have_http_status(:created)
      end
    end

    context 'with invalid params' do
      it 'returns errors' do
        post tenants_path, params: invalid_attributes
        expect(response).to have_http_status(:conflict)
        expect(json_response['errors']).to include('name', 'ip', 'url')
      end
    end
  end
end
