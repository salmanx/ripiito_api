require 'rails_helper'

RSpec.describe Tenants::CreateTenantOp do
  let(:valid_params) do
    {
      name: 'Test Tenant',
      ip: '192.168.1.1',
      url: 'https://example.com',
      location: 'Test Location',
    }
  end

  describe '#perform' do
    context 'with valid params' do
      it 'creates a tenant' do
        op = described_class.submit(valid_params)
        expect(op).to be_success
        expect(op.tenant).to be_persisted
      end
    end

    context 'with invalid params' do
      it 'fails with no URL passed' do
        op = described_class.submit(valid_params.merge(url: ''))
        expect(op).to be_failure
        expect(op.errors[:url]).to include('must provide URL')
      end

      it 'fails with no IP passed' do
        op = described_class.submit(valid_params.merge(ip: ''))
        expect(op).to be_failure
        expect(op.errors[:ip]).to include('must provide an ip')
      end

      it 'fails with missing name' do
        op = described_class.submit(valid_params.except(:name))
        expect(op).to be_failure
        expect(op.errors[:name]).to include("can't be blank")
      end
    end
  end

  describe 'validations' do
    it 'validates URL format' do
      op = described_class.submit(valid_params.merge(url: 'htt://invalid.com'))
      expect(op).to be_failure
      expect(op.errors[:url]).to include('must be a valid URL')
    end

    it 'validates IP format' do
      op = described_class.submit(valid_params.merge(ip: '10.20.0'))
      expect(op).to be_failure
      expect(op.errors[:ip]).to include('must be a valid ip')
    end
  end
end
