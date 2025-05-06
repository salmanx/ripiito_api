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
      base_price: 1000.00,
      plan_id: plan.id,
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
      expect(op.errors[:name]).to include("can't be blank")
    end

    it 'validates billing_period_unit' do
      op = described_class.submit(valid_params.merge(billing_period_unit: 'NOT_A_UNIT'))
      expect(op).to be_failure
      expect(op.errors[:billing_period_unit]).to include('is not included in the list')
    end

    it 'validates plan' do
      expect do
        described_class.submit(valid_params.merge(plan_id: nil))
      end.to raise_error(ActiveRecord::RecordNotFound)

      expect do
        described_class.submit(valid_params.merge(plan_id: 100))
      end.to raise_error(ActiveRecord::RecordNotFound)
    end
  end
end
