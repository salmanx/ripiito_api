# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Package, type: :model do
  subject { build(:package) }

  describe 'validations' do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_length_of(:name).is_at_least(3).is_at_most(100) }
    it { is_expected.to validate_presence_of(:status) }
    it { is_expected.to validate_inclusion_of(:status).in_array(Enum::PackageEnum::STATUSES.values) }
    it { is_expected.to validate_presence_of(:billing_period) }
    it { is_expected.to validate_numericality_of(:billing_period).only_integer }
    it { is_expected.to validate_presence_of(:billing_period_unit) }
    it {
      is_expected.to validate_inclusion_of(:billing_period_unit)
        .in_array(Enum::PackageEnum::BILLING_PERIOD_UNITS.values)
    }
    it { is_expected.to allow_value(true, false).for(:auto_renewable) }
    it { is_expected.not_to allow_value(nil).for(:auto_renewable) }
    it { is_expected.to allow_value(true, false).for(:cancelable) }
    it { is_expected.not_to allow_value(nil).for(:cancelable) }
    it { is_expected.to validate_numericality_of(:trial_days).only_integer.allow_nil }
    it { is_expected.to validate_numericality_of(:max_subscriber).only_integer.allow_nil }
    it { is_expected.to validate_presence_of(:pricing_type) }
    it {
      is_expected.to validate_inclusion_of(:pricing_type)
        .in_array(Enum::PackageEnum::PRICING_TYPE.values)
    }
    it { is_expected.to validate_presence_of(:pricing_model) }
    it {
      is_expected.to validate_inclusion_of(:pricing_model)
        .in_array(Enum::PackageEnum::PRICING_MODEL.values)
    }
    it { is_expected.to validate_presence_of(:package_type) }
    it {
      is_expected.to validate_inclusion_of(:package_type)
        .in_array(Enum::PackageEnum::PACKAGE_TYPE.values)
    }
  end

  describe 'associations' do
    it { should belong_to(:plan) }
    it { should have_one(:package_price).dependent(:destroy) }
  end
end
