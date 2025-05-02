require 'rails_helper'

RSpec.describe TenantsController, type: :controller do
  let(:tenant) { create(:tenant) }

  describe 'GET #show' do
    it 'returns the tenant' do
      get :show, params: { id: tenant.id }
      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body)['uuid']).to eq(tenant.uuid)
    end
  end

  describe 'POST #create' do
    context 'with valid params' do
      let(:valid_params) do
        {
          tenant: {
            name: 'New Tenant',
            ip: '192.168.1.1',
            url: 'https://example.com',
            location: 'New Location',
          },
        }
      end

      it 'creates a new tenant' do
        expect do
          post :create, params: valid_params
        end.to change(Tenant, :count).by(1)
        expect(response).to have_http_status(:created)
      end
    end

    context 'with invalid params' do
      let(:invalid_params) do
        {
          tenant: {
            name: '',
            ip: 'invalid',
            url: 'invalid',
            location: 'L',
          },
        }
      end

      it 'returns errors' do
        post :create, params: invalid_params
        expect(response).to have_http_status(:conflict)
        body = JSON.parse(response.body)
        expect(body['errors']).to include('name', 'ip', 'url')
      end
    end
  end
end
