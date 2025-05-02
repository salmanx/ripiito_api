require 'rails_helper'

RSpec.describe Tenant, type: :model do
  subject { build(:tenant) }

  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_length_of(:name).is_at_least(2).is_at_most(40) }
  it { is_expected.to validate_presence_of(:ip) }
  it { is_expected.to validate_length_of(:location).is_at_least(3).is_at_most(250).allow_nil }
  it { is_expected.to validate_presence_of(:url) }
  it { is_expected.to validate_length_of(:url).is_at_least(12).is_at_most(40) }

  describe '#generate_slug' do
    let(:tenant) { build(:tenant, name: 'Test Tenant') }

    it 'generates slug before validation' do
      expect(tenant.slug).to be_nil
      tenant.valid?
      expect(tenant.slug).to eq('test-tenant')
    end
  end
end
