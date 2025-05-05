# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Plan, type: :model do
  subject { build(:plan) }

  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_length_of(:name).is_at_least(3).is_at_most(100) }

  it { is_expected.to validate_presence_of(:status) }
  it { is_expected.to validate_inclusion_of(:status).in_array(Enum::PlanEnum::STATUSES.values) }

  it { is_expected.to validate_presence_of(:billing_period) }
  it { is_expected.to validate_numericality_of(:billing_period).only_integer }

  it { is_expected.to validate_presence_of(:billing_period_unit) }
  it {
    is_expected.to validate_inclusion_of(:billing_period_unit)
      .in_array(Enum::PlanEnum::BILLING_PERIOD_UNITS.values)
  }

  it { is_expected.to validate_presence_of(:duration) }
  it { is_expected.to validate_numericality_of(:duration).only_integer }

  it { is_expected.to allow_value(true, false).for(:auto_renewable) }
  it { is_expected.not_to allow_value(nil).for(:auto_renewable) }

  it { is_expected.to allow_value(true, false).for(:cancelable) }
  it { is_expected.not_to allow_value(nil).for(:cancelable) }

  it { is_expected.to validate_presence_of(:base_price) }
  it { is_expected.to validate_numericality_of(:base_price).is_greater_than(0) }

  it { is_expected.to validate_numericality_of(:trial_days).only_integer.is_greater_than(0).allow_nil }

  it { is_expected.to allow_value(true, false, nil).for(:is_price_visible) }

  it { is_expected.to validate_presence_of(:currency) }
  it { is_expected.to validate_inclusion_of(:currency).in_array(Enum::PlanEnum::CURRENCY_CODE.values) }

  it { is_expected.to validate_numericality_of(:max_subscriber).only_integer.allow_nil }

  it { is_expected.to allow_value(true, false).for(:taxable) }
  it { is_expected.not_to allow_value(nil).for(:taxable) }

  context 'when taxable is true, requires tax_fee' do
    subject { build(:plan, taxable: true) }

    it { is_expected.to validate_presence_of(:tax_fee) }
    it { is_expected.to validate_numericality_of(:tax_fee).is_greater_than(0) }
  end
end
