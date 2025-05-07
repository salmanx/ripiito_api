# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Tenants::CreateTenantOp do
  let(:valid_params) do
    {
      name: Faker::Company.name[0...10],
      url: Faker::Internet.url(host: 'test'),
      location: Faker::Address.full_address[0..15],
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
        expect(op.errors[:url]).to include('url must provide URL')
      end

      it 'fails with no IP passed' do
        op = described_class.submit(valid_params.merge(ip: '121.1.test'))
        expect(op).to be_failure
        expect(op.errors[:ip]).to include('ip must be a valid ip')
      end

      it 'fails with missing name' do
        op = described_class.submit(valid_params.except(:name))
        expect(op).to be_failure
        expect(op.errors[:name]).to include("name can't be blank")
      end
    end
  end

  describe 'validations' do
    it 'validates URL format' do
      op = described_class.submit(valid_params.merge(url: 'htt://invalid.com'))
      expect(op).to be_failure
      expect(op.errors[:url]).to include('url must be a valid URL')
    end

    it 'validates IP format' do
      op = described_class.submit(valid_params.merge(ip: '10.20.0'))
      expect(op).to be_failure
      expect(op.errors[:ip]).to include('ip must be a valid ip')
    end
  end
end
