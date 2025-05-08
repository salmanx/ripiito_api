# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Plans::CreatePlanOp do
  let(:tenant) { create(:tenant) }

  let(:valid_params) do
    {
      name: Faker::Company.name[0...10],
      duration: 120,
      tenant_id: tenant.id,
    }
  end

  describe '#perform' do
    context 'with valid params' do
      it 'creates a plan' do
        op = described_class.submit(valid_params)
        expect(op).to be_success
        expect(op.plan).to be_persisted
      end
    end
  end

  describe 'validations' do
    it 'validates name' do
      op = described_class.submit(valid_params.merge(name: ''))
      expect(op).to be_failure
      expect(op.errors[:name]).to include("can't be blank")
    end

    it 'validates tenant' do
      expect do
        described_class.submit(valid_params.merge(tenant_id: nil))
      end.to raise_error(ActiveRecord::RecordNotFound)

      expect do
        described_class.submit(valid_params.merge(tenant_id: 100))
      end.to raise_error(ActiveRecord::RecordNotFound)
    end
  end
end
