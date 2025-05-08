# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Packages::CreatePackageOp do
  let(:plan) { create(:plan) }

  let(:valid_params) do
    {
      name: Faker::Company.name[0...10],
      billing_period: 1,
      billing_period_unit: 'MONTH',
      status: 'DRAFT',
      package_type: 'REQUIRED',
      pricing_model: 'FIXED',
      pricing_type: 'RECURRING',
      plan_id: plan.id,
      package_price_attributes: {
        price: 100,
      },
    }
  end

  describe '#perform' do
    context 'with valid params' do
      it 'creates a package' do
        op = described_class.submit(valid_params)
        puts op.errors.full_messages.inspect
        expect(op).to be_success
        expect(op.package).to be_persisted
      end
    end
  end

  describe 'validations' do
    it 'validates name' do
      op = described_class.submit(valid_params.merge(name: ''))
      expect(op).to be_failure
      expect(op.errors[:name]).to include("name can't be blank")
    end

    it 'validates billing_period_unit' do
      op = described_class.submit(valid_params.merge(billing_period_unit: 'NOT_A_UNIT'))
      expect(op).to be_failure
      expect(op.errors[:billing_period_unit]).to include('billing_period_unit is not included in the list')
    end

    it 'validates plan' do
      op = described_class.submit(valid_params.merge(plan_id: nil))
      expect(op.errors[:plan]).to include('must exist')
    end
  end
end
