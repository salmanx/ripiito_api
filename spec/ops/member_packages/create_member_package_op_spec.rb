# frozen_string_literal: true

require 'rails_helper'

RSpec.describe MemberPackages::CreateMemberPackageOp do
  let(:package) { create(:package) }
  let(:member) { create(:member) }

  let(:valid_params) do
    {
      package_id: package.id,
      email: member.email,
      purchase_price: 100.00,
      tax_fee: 0.0,
      total_price: 100.00,
      payment_method: 'COD',
    }
  end

  describe '#perform' do
    context 'with valid params' do
      it 'creates a package' do
        op = described_class.submit(valid_params)
        puts op.errors.full_messages.inspect
        expect(op).to be_success
        expect(op.member_package).to be_persisted
      end
    end
  end

  describe 'validations' do
    it 'validates email presence' do
      op = described_class.submit(valid_params.merge(email: ''))
      expect(op).to be_failure
      expect(op.errors[:email]).to include("can't be blank!")
    end

    it 'validates member presence' do
      op = described_class.submit(valid_params.merge(email: ''))
      expect(op).to be_failure
      expect(op.errors[:member]).to include('must exist')
    end

    it 'validates package presence' do
      op = described_class.submit(valid_params.merge(package_id: ''))
      expect(op).to be_failure
      expect(op.errors[:package]).to include('must exist')
    end
  end
end
